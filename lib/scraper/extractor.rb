module Scraper
  class Extractor
    def self.teams_from_page(league, page)
      team_table = page.search('//*[@id="jsn-mainbody"]/table[3]/tr/td[2]').search('a').each do |team_line|
        name = team_line.text
        external_mtfv_team_id = external_mtfv_id_from_link(team_line.attr('href'))
        Team.create_with(
          league_id: league.id,
          name: name
        ).find_or_create_by(external_mtfv_id: external_mtfv_team_id)
      end
    end

    def self.matches_from_page(league, page)
      match_table = page.search('//*[@id="jsn-mainbody"]/table[4]/tr').each do |match_line|
        # skip rows with no information
        next if match_line.attr("class") != "sectiontableentry2" && match_line.attr("class") != "sectiontableentry1"

        # match hasn't been played yet
        next if match_line.children[1].children[3].nil?

        result_link = match_line.children[1].children[3].attr("href")

        match_date = Time.parse(match_line.children[1].children[3].children[0].text)

        external_mtfv_match_id = external_mtfv_id_from_link(result_link)
        external_mtfv_home_team_id = external_mtfv_id_from_link(match_line.children[3].children[1].attr("href"))
        external_mtfv_away_team_id = external_mtfv_id_from_link(match_line.children[5].children[1].attr("href"))

        match = Match.create_with(
          home_team_id: internal_id_from_external_mtfv_id(Team, external_mtfv_home_team_id),
          away_team_id: internal_id_from_external_mtfv_id(Team, external_mtfv_away_team_id),
          played_at: match_date,
          league_id: league.id,
        ).find_or_create_by!(external_mtfv_id: external_mtfv_match_id)

        # cleanup results before importing again
        match.results.destroy_all
        results_from_match_link(result_link)
      end
    end

    def self.results_from_match_link(result_link)
      external_mtfv_match_id = external_mtfv_id_from_link(result_link)
      agent = Mechanize.new

      # puts "importing match #{external_mtfv_match_id}"

      result_page = agent.get("http://www.mtfv1.de#{result_link}")
      result_page.search('//*/table[3]').search("tr").each do |tr_line|
        next if tr_line.attr("class") != "sectiontableentry2" && tr_line.attr("class") != "sectiontableentry1"

        # single game default win away
        if tr_line.search("td")[3].children[1].nil?
          home_player_ids = [0]
          home_goals, away_goals = score_from_td(tr_line.search("td")[4])
          away_player_ids = [0]
        # regular double game
        elsif tr_line.search("td")[3].children[1].name == "img"
          home_player_ids = double_player_id_from_td(tr_line.search("td")[4])
          home_goals, away_goals = score_from_td(tr_line.search("td")[5])
          away_player_ids = double_player_id_from_td(tr_line.search("td")[6])
        # regular single game
        else
          home_player_ids = single_player_id_from_td(tr_line.search("td")[3])
          home_goals, away_goals = score_from_td(tr_line.search("td")[4])
          away_player_ids = single_player_id_from_td(tr_line.search("td")[5])
        end

        # puts "#{home_player_ids} #{home_goals}:#{away_goals} #{away_player_ids}"
        Result.create!(
          match_id: internal_id_from_external_mtfv_id(Match, external_mtfv_match_id),
          home_player_ids: home_player_ids,
          away_player_ids: away_player_ids,
          home_goals: home_goals,
          away_goals: away_goals,
        )
      end
    end

    def self.double_player_id_from_td(td_line)
      # regular double game
      if td_line.children[1]
        external_mtfv_player_one_id = external_mtfv_id_from_link(td_line.children[1].attr("href"))
        name_player_one  = td_line.children[1].text.strip
      else
        external_mtfv_player_one_id = 9999999
        name_player_one = "Unbekannt"
      end

      if td_line.children[4]
        external_mtfv_player_two_id = external_mtfv_id_from_link(td_line.children[4].attr("href"))
        name_player_two = td_line.children[4].text.strip
      else
        external_mtfv_player_two_id = 9999998
        name_player_two = "Unbekannt"
      end

      [
        create_or_find_player(external_mtfv_player_one_id, name_player_one).id,
        create_or_find_player(external_mtfv_player_two_id, name_player_two).id
      ]
    end

    def self.single_player_id_from_td(td_line)
      # regular single game
      if td_line.children[1]
        external_mtfv_player_id = external_mtfv_id_from_link(td_line.children[1].attr("href"))
        name_player = td_line.text.strip
      else
        external_mtfv_player_id = 9999999
        name_player = "Unbekannt"
      end

      [
        create_or_find_player(external_mtfv_player_id, name_player).id
      ]
    end

    def self.score_from_td(score_td)
      score_td.text.split(":")
    end

    def self.external_mtfv_id_from_link(link)
      return if link.nil?

      CGI::parse(link)["id"].first.to_i
    end

    def self.create_or_find_player(external_mtfv_id, name)
      Player.create_with(
        name: name,
      ).find_or_create_by!(external_mtfv_id: external_mtfv_id)
    end

    def self.internal_id_from_external_mtfv_id(klass, external_mtfv_id)
      klass.where(external_mtfv_id: external_mtfv_id).first.id
    end
  end
end
