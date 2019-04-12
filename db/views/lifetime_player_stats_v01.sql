SELECT
    player_stats.player_id,
    SUM(player_stats.overall_performance_index) AS overall_performance_index,
    SUM(player_stats.overall_score) AS overall_score,
    SUM(player_stats.overall_score_against) AS overall_score_against,
    SUM(player_stats.overall_goals) AS overall_goals,
    SUM(player_stats.overall_goals_against) AS overall_goals_against,
    SUM(player_stats.single_performance_index) AS single_performance_index,
    SUM(player_stats.single_score) AS single_score,
    SUM(player_stats.single_score_against) AS single_score_against,
    SUM(player_stats.single_goals) AS single_goals,
    SUM(player_stats.single_goals_against) AS single_goals_against,
    SUM(player_stats.double_performance_index) AS double_performance_index,
    SUM(player_stats.double_score) AS double_score,
    SUM(player_stats.double_score_against) AS double_score_against,
    SUM(player_stats.double_goals) AS double_goals,
    SUM(player_stats.double_goals_against) AS double_goals_against
FROM
    player_stats
GROUP BY
    player_stats.player_id;
