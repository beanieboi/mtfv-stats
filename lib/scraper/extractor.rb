module Scraper
  class Extractor
    def self.teams_from_page(page)
      team_table = page.search('//*[@id="jsn-mainbody"]/table[3]/tr/td[2]').search('a').each do |team_line|
        name = team_line.text
        external_mtfv_team_id = external_mtfv_id_from_link(team_line.attr('href'))
        Team.create_with(name: name).find_or_create_by(external_mtfv_id: external_mtfv_team_id)
      end
    end

    def self.matches_from_page(page)
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

        Match.create_with(
          home_team_id: internal_id_from_external_mtfv_id(Team, external_mtfv_home_team_id),
          away_team_id: internal_id_from_external_mtfv_id(Team, external_mtfv_away_team_id),
          played_at: match_date,
        ).find_or_create_by!(external_mtfv_id: external_mtfv_match_id)

        results_from_match_link(result_link)
      end
    end

    def self.results_from_match_link(result_link)
      puts "importing results for #{result_link}"
      external_mtfv_match_id = external_mtfv_id_from_link(result_link)
      agent = Mechanize.new

      result_page = agent.get("http://www.mtfv1.de#{result_link}")
      result_page.search('//*/table[3]').search("tr").each do |tr_line|
        next if tr_line.attr("class") != "sectiontableentry2" && tr_line.attr("class") != "sectiontableentry1"

        # Spiel ist Doppel
        if tr_line.search("td")[3].children[1].name == "img"
          home_player_ids = double_player_id_from_td(tr_line.search("td")[4])
          home_score, away_score = score_from_td(tr_line.search("td")[5])
          away_player_ids = double_player_id_from_td(tr_line.search("td")[6])
        else
          home_player_ids = single_player_id_from_td(tr_line.search("td")[3])
          home_score, away_score = score_from_td(tr_line.search("td")[4])
          away_player_ids = single_player_id_from_td(tr_line.search("td")[5])
        end

        Result.find_or_create_by(
            match_id: internal_id_from_external_mtfv_id(Match, external_mtfv_match_id),
            home_player_ids: home_player_ids,
            away_player_ids: away_player_ids,
            home_score: home_score,
            away_score: away_score,
          )
      end
    end

    def self.double_player_id_from_td(td_line)
      external_mtfv_player_one_id = external_mtfv_id_from_link(td_line.children[1].attr("href"))
      external_mtfv_player_two_id = external_mtfv_id_from_link(td_line.children[4].attr("href"))

      [
        create_or_find_player(external_mtfv_player_one_id, td_line.children[1].text.strip).id,
        create_or_find_player(external_mtfv_player_two_id, td_line.children[4].text.strip).id
      ]
    end

    def self.single_player_id_from_td(td_line)
      external_mtfv_player_id = external_mtfv_id_from_link(td_line.children[1].attr("href"))

      [
        create_or_find_player(external_mtfv_player_id, td_line.text.strip).id
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

__END__
//*[@id="jsn-mainbody"]/table[5]
//*[@id="jsn-mainbody"]/table[2]/tr

http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=begegnung_spielplan&veranstaltungid=37&id=1550
http://www.mtfv1.de/index.php/de/design-and-features/verbandsligen?task=begegnung_spielplan&veranstaltungid=37&id=1550

/html/body/div[1]/div/div[3]/div/div/div[1]/div/div/div/table[5]/tbody/tr[2]
