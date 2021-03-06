-- Average Elo
SELECT round(avg(elo_rating)) overall, round(avg(recent_elo_rating)) recent, round(avg(hard_elo_rating)) hard, round(avg(clay_elo_rating)) clay, round(avg(grass_elo_rating)) grass, round(avg(carpet_elo_rating)) carpet, round(avg(outdoor_elo_rating)) outdoor, round(avg(indoor_elo_rating)) indoor, round(avg(set_elo_rating)) "set", round(avg(game_elo_rating)) game, round(avg(service_game_elo_rating)) service_game, round(avg(return_game_elo_rating)) return_game, round(avg(tie_break_elo_rating)) tie_break
FROM player_elo_ranking
WHERE rank <= 50;

-- Average Elo by Season
SELECT extract(YEAR FROM rank_date) season, round(avg(elo_rating)) overall, round(avg(recent_elo_rating)) recent, round(avg(hard_elo_rating)) hard, round(avg(clay_elo_rating)) clay, round(avg(grass_elo_rating)) grass, round(avg(carpet_elo_rating)) carpet, round(avg(outdoor_elo_rating)) outdoor, round(avg(indoor_elo_rating)) indoor, round(avg(set_elo_rating)) "set", round(avg(game_elo_rating)) game, round(avg(service_game_elo_rating)) service_game, round(avg(return_game_elo_rating)) return_game, round(avg(tie_break_elo_rating)) tie_break
FROM player_elo_ranking
WHERE rank <= 50
GROUP BY season
ORDER BY season DESC;

-- Average Elo by Rank
WITH avg_elo_rating AS (
	SELECT 1 rank, round(avg(elo_rating)) overall, round(avg(recent_elo_rating)) recent, round(avg(hard_elo_rating)) hard, round(avg(clay_elo_rating)) clay, round(avg(grass_elo_rating)) grass, round(avg(carpet_elo_rating)) carpet, round(avg(outdoor_elo_rating)) outdoor, round(avg(indoor_elo_rating)) indoor, round(avg(set_elo_rating)) "set", round(avg(game_elo_rating)) game, round(avg(service_game_elo_rating)) service_game, round(avg(return_game_elo_rating)) return_game, round(avg(tie_break_elo_rating)) tie_break FROM player_elo_ranking WHERE rank = 1
	UNION SELECT 3, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 3
	UNION SELECT 2, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 2
	UNION SELECT 4, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 4
	UNION SELECT 5, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 5
	UNION SELECT 7, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 7
	UNION SELECT 10, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 10
	UNION SELECT 15, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 15
	UNION SELECT 20, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 20
	UNION SELECT 30, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 30
	UNION SELECT 50, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 50
	UNION SELECT 70, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 70
	UNION SELECT 100, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 100
	UNION SELECT 150, round(avg(elo_rating)), round(avg(recent_elo_rating)), round(avg(hard_elo_rating)), round(avg(clay_elo_rating)), round(avg(grass_elo_rating)), round(avg(carpet_elo_rating)), round(avg(outdoor_elo_rating)), round(avg(indoor_elo_rating)), round(avg(set_elo_rating)), round(avg(game_elo_rating)), round(avg(service_game_elo_rating)), round(avg(return_game_elo_rating)), round(avg(tie_break_elo_rating)) FROM player_elo_ranking WHERE rank = 150
	UNION SELECT 200, round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)), round(avg(elo_rating)) FROM player_elo_ranking WHERE rank = 200
)
SELECT rank, overall, recent, round((recent - 1500) / (overall - 1500), 3) recent_factor, hard, clay, grass, carpet, outdoor, indoor,
	set, round((set - 1500) / (overall - 1500), 3) set_factor,
	game, round((game - 1500) / (overall - 1500), 3) game_factor,
	service_game, round((service_game - 1500) / (overall - 1500), 3) service_game_factor,
	return_game, round((return_game - 1500) / (overall - 1500), 3) return_game_factor,
	tie_break, round((tie_break - 1500) / (overall - 1500), 3) tie_break_factor
FROM avg_elo_rating
ORDER BY rank;


SELECT 1 / avg(w_sets - l_sets) set_factor, 1 / avg(w_games - l_games) game_factor, 2 / avg(w_games - l_games) service_return_game_factor, 1 / avg(w_tbs - l_tbs) tie_break_factor
FROM match_for_stats_v;


SELECT surface, GROUPING(surface), sum(w_bp_fc - w_bp_sv + l_bp_fc - l_bp_sv)::REAL / sum(w_sv_gms - (w_bp_fc - w_bp_sv) + l_sv_gms - (l_bp_fc - l_bp_sv)) shr
FROM match_stats
INNER JOIN match USING (match_id)
GROUP BY ROLLUP(surface)
ORDER BY surface, 2;