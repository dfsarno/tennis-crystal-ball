package org.strangeforest.tcb.stats.model.prediction;

public enum RecentFormPredictionItem implements PredictionItem {

	OVERALL(5.0),
	SURFACE(4.0),
	LEVEL(5.0);

	private volatile PredictionArea area;
	private volatile double weight;

	RecentFormPredictionItem(double weight) {
		this.weight = weight;
	}

	@Override public PredictionArea getArea() {
		return area;
	}

	@Override public void setArea(PredictionArea area) {
		this.area = area;
	}

	@Override public double getWeight() {
		return weight;
	}

	@Override public void setWeight(double weight) {
		this.weight = weight;
		area.calculateItemAdjustmentWeight();
	}

	@Override public String toString() {
		return area + "[" + super.toString() + "]";
	}
}
