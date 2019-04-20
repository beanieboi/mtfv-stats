module ApplicationHelper
  def linked_player_names(players)
    if players.count > 1
      link_to(players.first.name, player_path(players.first.id)) +
      " und " +
      link_to(players.last.name, player_path(players.last.id))
    else
      link_to(players.first.name, player_path(players.first.id))
    end
  end
end
