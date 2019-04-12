SELECT
    double_stats.player_ids,
    SUM(double_stats.overall_performance_index) AS overall_performance_index,
    SUM(double_stats.overall_score) AS overall_score,
    SUM(double_stats.overall_score_against) AS overall_score_against,
    SUM(double_stats.overall_goals) AS overall_goals,
    SUM(double_stats.overall_goals_against) AS overall_goals_against
FROM
    double_stats
GROUP BY
    double_stats.player_ids;
