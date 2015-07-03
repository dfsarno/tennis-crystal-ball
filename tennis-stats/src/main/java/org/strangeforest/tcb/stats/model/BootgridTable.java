package org.strangeforest.tcb.stats.model;

import java.util.*;

public class BootgridTable<R> {

	private int current;
	private int rowCount;
	private List<R> rows = new ArrayList<>();
	private int total;

	public BootgridTable() {
		this(1, 0);
	}

	public BootgridTable(int current, int total) {
		this.current = current;
		this.total = total;
	}

	public int getCurrent() {
		return current;
	}

	public int getRowCount() {
		return rowCount;
	}

	public List<R> getRows() {
		return rows;
	}

	public void addRow(R row) {
		rows.add(row);
		rowCount++;
	}

	public int getTotal() {
		return total != 0 ? total : rowCount;
	}
}
