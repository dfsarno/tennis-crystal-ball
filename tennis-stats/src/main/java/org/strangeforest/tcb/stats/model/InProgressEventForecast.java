package org.strangeforest.tcb.stats.model;

import java.util.*;
import java.util.Map.*;

public class InProgressEventForecast {

	private final InProgressEvent event;
	private final Map<String, PlayersForecast> playersForecasts;

	private static final String CURRENT = "Current";

	public InProgressEventForecast(InProgressEvent event) {
		this.event = event;
		playersForecasts = new LinkedHashMap<>();
	}

	public InProgressEvent getEvent() {
		return event;
	}

	public Set<String> getBaseResults() {
		return playersForecasts.keySet();
	}

	public PlayersForecast getPlayersForecasts(String baseResult) {
		return playersForecasts.get(baseResult);
	}

	public void addForecast(List<PlayerForecast> players, int playerId, String baseResult, String result, double probability) {
		baseResult = baseResult.equals("W") ? CURRENT : baseResult;
		playersForecasts.computeIfAbsent(baseResult, round -> new PlayersForecast(players)).addResult(playerId, result, probability);
	}

	public void process() {
		if (playersForecasts.isEmpty())
			return;
		Set<String> baseResults = getBaseResults();
		if (baseResults.size() <= 2)
			return;
		String entryRound = baseResults.iterator().next();
		for (Entry<String, PlayersForecast> forecastEntry : playersForecasts.entrySet()) {
			if (!forecastEntry.getKey().equals(entryRound))
				forecastEntry.getValue().removePlayersWOResults();
		}
		PlayersForecast currentForecast = getPlayersForecasts(CURRENT);
		if (currentForecast != null)
			currentForecast.removePastRounds();
	}
}