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
        results_from_match_link(result_link)

        match_date = Time.parse(match_line.children[1].children[3].children[0].text)

        external_mtfv_match_id = external_mtfv_id_from_link(result_link)
        external_mtfv_home_team_id = external_mtfv_id_from_link(match_line.children[3].children[1].attr("href"))
        external_mtfv_away_team_id = external_mtfv_id_from_link(match_line.children[5].children[1].attr("href"))

        Match.create_with(
          home_team_id: team_id_from_external_mtfv_team_id(external_mtfv_home_team_id),
          away_team_id: team_id_from_external_mtfv_team_id(external_mtfv_away_team_id),
          played_at: match_date,
        ).find_or_create_by!(external_mtfv_id: external_mtfv_match_id)
      end
    end

    def self.results_from_match_link(result_link)
      puts "importing results for #{result_link}"
    end

    def self.external_mtfv_id_from_link(link)
      return if link.nil?

      CGI::parse(link)["id"].first
    end

    def self.team_id_from_external_mtfv_team_id(external_mtfv_id)
      Team.where(external_mtfv_id: external_mtfv_id).first.id
    end
  end
end
