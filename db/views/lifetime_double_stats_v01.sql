SELECT
    double_stats.player_ids,
    string_agg(concat(players.id, '---', players.name), '|||') AS player_data,
    SUM(double_stats.overall_performance_index) AS overall_performance_index,
    SUM(double_stats.overall_score) AS overall_score,
    SUM(double_stats.overall_score_against) AS overall_score_against,
    SUM(double_stats.overall_goals) AS overall_goals,
    SUM(double_stats.overall_goals_against) AS overall_goals_against
FROM
    double_stats
LEFT JOIN
  players ON (players.id = ANY(double_stats.player_ids))
GROUP BY
    double_stats.player_ids;
