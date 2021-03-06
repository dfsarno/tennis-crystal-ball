package org.strangeforest.tcb.stats.prediction;

import java.io.*;
import java.time.*;
import java.util.function.*;
import java.util.stream.*;

import org.springframework.boot.test.context.*;
import org.springframework.test.context.*;
import org.strangeforest.tcb.stats.model.prediction.*;
import org.testng.annotations.*;

import static java.util.Arrays.*;
import static java.util.Comparator.*;
import static java.util.stream.Collectors.*;
import static org.strangeforest.tcb.stats.model.prediction.PredictionArea.*;

@ContextConfiguration(classes = PredictionITsConfig.class, initializers = ConfigFileApplicationContextInitializer.class)
public class PredictionTuningIT extends BasePredictionVerificationIT {

	private static final LocalDate FROM_DATE = LocalDate.of(2005, 1, 1);
	private static final LocalDate TO_DATE = LocalDate.now();
	private static final TuningSet TUNING_SET = TuningSet.OVERALL;
	private static final Function<PredictionResult, Double> METRICS = PredictionResult::getScore;
	private static final boolean SAVE_BEST_CONFIG = false;


	// Starting from default weights

	@Test
	public void tuneDefaultPrediction() throws InterruptedException {
		doTunePrediction(PredictionConfig.defaultConfig(TUNING_SET));
	}

	@Test
	public void tuneDefaultPredictionByArea() throws InterruptedException {
		doTunePredictionByArea(PredictionConfig.defaultConfig(TUNING_SET));
	}

	@Test
	public void tuneDefaultPredictionByItem() throws InterruptedException {
		doTunePredictionByItem(PredictionConfig.defaultConfig(TUNING_SET));
	}

	@Test
	public void tuneDefaultPredictionInRankingArea() throws InterruptedException {
		doTunePredictionInArea(PredictionConfig.defaultConfig(TUNING_SET), RANKING);
	}

	@Test
	public void tuneDefaultPredictionInRecentFormArea() throws InterruptedException {
		doTunePredictionInArea(PredictionConfig.defaultConfig(TUNING_SET), RECENT_FORM);
	}

	@Test
	public void tuneDefaultPredictionInH2HArea() throws InterruptedException {
		doTunePredictionInArea(PredictionConfig.defaultConfig(TUNING_SET), H2H);
	}

	@Test
	public void tuneDefaultPredictionInWinningPctArea() throws InterruptedException {
		doTunePredictionInArea(PredictionConfig.defaultConfig(TUNING_SET), WINNING_PCT);
	}


	// Starting from equal weights

	@Test @Ignore
	public void tunePrediction() throws InterruptedException {
		doTunePrediction(PredictionConfig.equalWeights());
	}

	@Test @Ignore
	public void tunePredictionByArea() throws InterruptedException {
		doTunePredictionByArea(PredictionConfig.equalWeights());
	}

	@Test @Ignore
	public void tunePredictionByItem() throws InterruptedException {
		doTunePredictionByItem(PredictionConfig.equalWeights());
	}

	@Test @Ignore
	public void tunePredictionInRankingArea() throws InterruptedException {
		doTunePredictionInAreaFromPointZero(RANKING);
	}

	@Test @Ignore
	public void tunePredictionInRecentFormArea() throws InterruptedException {
		doTunePredictionInAreaFromPointZero(RECENT_FORM);
	}

	@Test @Ignore
	public void tunePredictionInH2HArea() throws InterruptedException {
		doTunePredictionInAreaFromPointZero(H2H);
	}

	@Test @Ignore
	public void tunePredictionInWinningPctArea() throws InterruptedException {
		doTunePredictionInAreaFromPointZero(WINNING_PCT);
	}


	// Tuning

	private void doTunePrediction(PredictionConfig config) throws InterruptedException {
		tunePrediction(config,  Stream.of(PredictionArea.values()).flatMap(area -> Stream.of(area.getAreaAndItems())).collect(toList()), METRICS);
	}

	private void doTunePredictionByArea(PredictionConfig config) throws InterruptedException {
		tunePrediction(config, asList(PredictionArea.values()), METRICS);
	}

	private void doTunePredictionByItem(PredictionConfig config) throws InterruptedException {
		tunePrediction(config, Stream.of(PredictionArea.values()).flatMap(area -> Stream.of(area.getItems())).collect(toList()), METRICS);
	}

	private void doTunePredictionInAreaFromPointZero(PredictionArea area) throws InterruptedException {
		tunePrediction(PredictionConfig.areaEqualWeights(area), asList(area.getItems()), METRICS);
	}

	private void doTunePredictionInArea(PredictionConfig config, PredictionArea area) throws InterruptedException {
		tunePrediction(config, asList(area.getItems()), METRICS);
	}

	private void tunePrediction(PredictionConfig config, Iterable<Weighted> features, Function<PredictionResult, Double> metrics) throws InterruptedException {
		TuningContext context = new TuningContext(comparing(metrics));
		PredictionVerificationResult result = verifyPrediction(FROM_DATE, TO_DATE, config, TUNING_SET);

		for (context.initialResult(result); context.startStep() != null; context.endStep()) {
			for (Weighted weighted : features) {
				PredictionConfig stepDownConfig = context.stepDown(weighted);
				if (stepDownConfig != null)
					tuningStep(context, stepDownConfig);
				PredictionConfig stepUpConfig = context.stepUp(weighted);
				if (stepUpConfig != null)
					tuningStep(context, stepUpConfig);
			}
		}
		context.finish();
	}

	private void tuningStep(TuningContext context, PredictionConfig config) throws InterruptedException {
		PredictionVerificationResult result = verifyPrediction(FROM_DATE, TO_DATE, config, TUNING_SET);
		if (context.nextResult(result)) {
			printWeights(config, false);
			printResultDistribution(result);
			if (SAVE_BEST_CONFIG) {
				try (PrintStream out = new PrintStream(new FileOutputStream("tennis-stats/src/main/resources" + PredictionConfig.getConfigFileName(TUNING_SET)))) {
					out.println("# TENNIS CRYSTAL BALL - " + TUNING_SET);
					out.println("# " + result.getResult());
					out.println("# " + result.getProbabilityRangeResults());
					out.println("# " + result.getSurfaceResults());
					out.println("# " + result.getLevelResults());
					out.println("# " + result.getBestOfResults());
					out.println("# " + result.getRankRangeResults());
					out.println("# Tuned at: " + LocalDateTime.now());
					out.println();
					config.save(out);
					out.flush();
				}
				catch (FileNotFoundException ex) {
					throw new IllegalArgumentException("Cannot save config", ex);
				}
			}
		}
	}
}
