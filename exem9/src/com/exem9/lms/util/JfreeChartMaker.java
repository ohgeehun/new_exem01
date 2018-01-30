package com.exem9.lms.util;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.text.AttributedString;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.TickUnits;
import org.jfree.chart.block.BlockBorder;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.PieSectionLabelGenerator;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.AreaRenderer;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;
import org.jfree.ui.RectangleEdge;
import org.jfree.ui.TextAnchor;
import org.jfree.ui.VerticalAlignment;
import org.jfree.util.Rotation;
import org.slf4j.Marker;

public class JfreeChartMaker {
	
	public JfreeChartMaker(String title) {
		super();
	}
	
	public JFreeChart makeBarChart(String type, DefaultCategoryDataset dataset) {
		Color[] c = new Color[10];

		c[0] = new Color(92, 179, 255);
		c[1] = new Color(212, 98, 255);
		c[2] = new Color(251, 185, 23);
		c[3] = new Color(0, 179, 162);
		c[4] = new Color(251, 85, 137);
		c[5] = new Color(40, 112, 227);
		c[6] = new Color(255, 143, 0);
		c[7] = new Color(181, 191, 7);
		c[8] = new Color(63, 157, 0);
		c[9] = new Color(206, 60, 146);
		
		if(type.equals("Bar3D")) {
			JFreeChart chart = createBar3DChart(dataset, c);
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(500, 270));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		} else if(type.equals("Area")) {
			JFreeChart chart = createAreaChart(dataset, c);
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(250, 250));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		} else {
			JFreeChart chart = createBar3DChart(dataset, c);
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(500, 270));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		}
	}
	
	public JFreeChart makePieChart(DefaultPieDataset dataset, String talkonType, int totalCount) {
		Color[] c = new Color[10];
		
		c[0] = new Color(92, 179, 255);
		c[1] = new Color(212, 98, 255);
		c[2] = new Color(251, 185, 23);
		c[3] = new Color(0, 179, 162);
		c[4] = new Color(251, 85, 137);
		c[5] = new Color(40, 112, 227);
		c[6] = new Color(255, 143, 0);
		c[7] = new Color(181, 191, 7);
		c[8] = new Color(63, 157, 0);
		c[9] = new Color(206, 60, 146);
		
		JFreeChart chart = createPie3DChart(dataset, c, totalCount);
		
		ChartPanel chartPanel = new ChartPanel(chart);
		
		chartPanel.setPreferredSize(new Dimension(500, 270));
		
		chartPanel.setEnforceFileExtensions(false);
		
		//setContentPane(chartPanel);
		
		return chart;
	}

	/*public JFreeChart start(String type){
		Color[] c = new Color[10];

		c[0] = new Color(92, 179, 255);
		c[1] = new Color(212, 98, 255);
		c[2] = new Color(251, 185, 23);
		c[3] = new Color(0, 179, 162);
		c[4] = new Color(251, 85, 137);
		c[5] = new Color(40, 112, 227);
		c[6] = new Color(255, 143, 0);
		c[7] = new Color(181, 191, 7);
		c[8] = new Color(63, 157, 0);
		c[9] = new Color(206, 60, 146);
		
		final DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		
		dataset.addValue(100,"최고점수","기획");
		dataset.addValue(1,"최저점수","기획");
		//dataset.addValue(40,"평균점수","기획");
		dataset.addValue(50,"최고점수","홍보");
		dataset.addValue(-30,"최저점수","홍보");
		//dataset.addValue(30,"평균점수","홍보");
		dataset.addValue(44,"최고점수","마케팅");
		dataset.addValue(25,"최저점수","마케팅");
		//dataset.addValue(32,"평균점수","마케팅");
		dataset.addValue(100,"최고점수","IT");
		dataset.addValue(50,"최저점수","IT");
		//dataset.addValue(70,"평균점수","IT");

		
		// create the chart...
		
		if(type.equals("Bar3D")) {
			JFreeChart chart = createBar3DChart(dataset, c, "0");
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(500, 270));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		} else if(type.equals("Area")) {
			JFreeChart chart = createAreaChart(dataset, c);
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(250, 250));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		} else if(type.equals("Pie3D")) {
			final DefaultPieDataset result = new DefaultPieDataset();
	        result.setValue("자바", new Double(43.2));
	        result.setValue("Visual Basic", new Double(10.0));
	        result.setValue("C/C++", new Double(17.5));
	        result.setValue("PHP", new Double(32.5));
	        result.setValue("펄", new Double(1.0));
	        
	        JFreeChart chart = createPie3DChart(result, c, 0);
	        
        	ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(500, 270));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		} else {
			JFreeChart chart = createBar3DChart(dataset, c, "0");
			
			ChartPanel chartPanel = new ChartPanel(chart);
			
			chartPanel.setPreferredSize(new Dimension(500, 270));
			
			chartPanel.setEnforceFileExtensions(false);
			
			//setContentPane(chartPanel);
			
			return chart;
		}
	}*/
	
	// ****************************************************************************
	// * JFREECHART DEVELOPER GUIDE                                               *
	// * The JFreeChart Developer Guide, written by David Gilbert, is available   *
	// * to purchase from Object Refinery Limited:                                *
	// *                                                                          *
	// * http://www.object-refinery.com/jfreechart/guide.html                     *
	// *                                                                          *
	// * Sales are used to provide funding for the JFreeChart project - please    *
	// * support us so that we can continue developing free software.             *
	// ****************************************************************************
		   
	/**
	 * Creates a chart.
	 *
	 * @param dataset  the dataset.
	 *
	 * @return The chart.
	 */
	private JFreeChart createBar3DChart(final CategoryDataset dataset, Color[] c) {
		           
		JFreeChart chart = ChartFactory.createBarChart3D(
				"바3D차트", 
				"X축", 
				"Y축", 
				dataset, 
				PlotOrientation.VERTICAL, 
				true, 
				true, 
				false
		);
		
		// NOW DO SOME OPTIONAL CUSTOMISATION OF THE CHART...
		// set the background color for the chart...
		//	         final StandardLegend legend = (StandardLegend) chart.getLegend();
		//      legend.setAnchor(StandardLegend.SOUTH);
		chart.setBackgroundPaint(Color.white);
		
		/*final TextTitle subtitle = new TextTitle("서브타이틀.");
		
		subtitle.setFont(new Font("돋움", Font.PLAIN, 12));
		
		subtitle.setPosition(RectangleEdge.TOP);
		
		//subtitle.setSpacer(new Spacer(Spacer.RELATIVE, 0.05, 0.05, 0.05, 0.05));
		
		subtitle.setVerticalAlignment(VerticalAlignment.BOTTOM);
		
		chart.addSubtitle(subtitle);*/
		
		// 제목
	    chart.getTitle().setFont(new Font("돋움", Font.BOLD, 15));
	    
	    //제목 히든
	    chart.getTitle().setText("");
	    
	    // 범례
	    chart.getLegend().setItemFont(new Font("돋움", Font.PLAIN, 12));
	    
	    //범례 위치
        chart.getLegend().setPosition(RectangleEdge.BOTTOM);
        
        //범례 테두리 굵기
        chart.getLegend().setBorder(0, 0, 0, 0);
        
    	//chart.getLegend().setVisible(false);
	     
	    CategoryPlot plot = chart.getCategoryPlot();
	     
	    Font font = plot.getDomainAxis().getLabelFont();
	    
	    //X축 라벨 Hidden
	    plot.getDomainAxis().setLabel(null);
	    
	    // X축 라벨
	    plot.getDomainAxis().setLabelFont(new Font("돋움",Font.PLAIN, font.getSize()));
	    // X축 도메인
	    plot.getDomainAxis().setTickLabelFont(new Font("돋움", Font.PLAIN, 12));
	    
	    font = plot.getRangeAxis().getLabelFont();
	    
	    //Y축 라벨 Hidden
	    plot.getRangeAxis().setLabel(null);
	    
	    // Y축 라벨
	    plot.getRangeAxis().setLabelFont(new Font("돋움", Font.PLAIN, font.getSize()));
	    // Y축 범위
	    plot.getRangeAxis().setTickLabelFont(new Font("돋움", Font.PLAIN, 12));
	    
	    /*NumberAxis bottomAxis = (NumberAxis) plot.getRangeAxis();
	    
	    bottomAxis.setLowerBound(0);
	    bottomAxis.setUpperBound(20);*/
	    
	    //plot.getRangeAxis().setLowerBound(0);
	    //plot.getRangeAxis().setUpperBound(20);
		
		//final CategoryPlot plot = chart.getCategoryPlot();
		
		plot.setForegroundAlpha(0.5f);
		
		//plot.setAxisOffset(new Spacer(Spacer.ABSOLUTE, 5.0, 5.0, 5.0, 5.0));
		plot.setBackgroundPaint(Color.lightGray);
		
		plot.setDomainGridlinesVisible(true);
		
		plot.setDomainGridlinePaint(Color.white);
		
		plot.setRangeGridlinesVisible(true);
		
		plot.setRangeGridlinePaint(Color.white);
		
		final CategoryAxis domainAxis = plot.getDomainAxis();
		
		//좌측 여백
		domainAxis.setLowerMargin(0.03);
		
		//우측 여백
		domainAxis.setUpperMargin(0.03);
		
		//카테고리간 간격
		domainAxis.setCategoryMargin(0.1);
		
		domainAxis.setLabelFont(new Font("돋움", font.getStyle(), 12));
		/*domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);*/
		
		/*domainAxis.setLowerMargin(0.0);
		
		domainAxis.setUpperMargin(0.0);*/
		
		/*domainAxis.setLabelFont(new Font("돋움", font.getStyle(), 10));
		
		domainAxis.addCategoryLabelToolTip("Type 1", "The first type.");
		
		domainAxis.addCategoryLabelToolTip("Type 2", "The second type.");
		
		domainAxis.addCategoryLabelToolTip("Type 3", "The third type.");*/
		   
		final NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
		
		rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		
		rangeAxis.setLabelAngle(0 * Math.PI / 2.0);
		
		CategoryItemRenderer renderer = plot.getRenderer();
		
		renderer.setBaseItemLabelsVisible(true);
		//renderer.setSeriesItemLabelsVisible(0, false);
		//renderer.setSeriesItemLabelsVisible(1, false);
		renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
		
		//아이템 라벨 포지셔닝
		ItemLabelPosition pos1 = new ItemLabelPosition(ItemLabelAnchor.OUTSIDE12, TextAnchor.CENTER); // 차트 data 위치 표현 ( 개고생했음) 
		renderer.setBasePositiveItemLabelPosition(pos1);
		
		BarRenderer br = (BarRenderer) plot.getRenderer();
		
		br.setSeriesPaint(0, c[0]);
		br.setSeriesPaint(1, c[1]);
		
		//바아이템 간격
		br.setItemMargin(0.0);
		
		//br.setSeriesPaint(2, c[2]);
		
		// OPTIONAL CUSTOMISATION COMPLETED.
		
		return chart;
	}
	
	/**
	 * Creates a chart.
	 *
	 * @param dataset  the dataset.
	 *
	 * @return The chart.
	 */
	private JFreeChart createAreaChart(final CategoryDataset dataset, Color[] c) {
		           
		JFreeChart chart = ChartFactory.createAreaChart(
			"에리어 차트",             // chart title
			"X",               // domain axis label
			"Y",                  // range axis label
			dataset,                  // data
			PlotOrientation.VERTICAL, // orientation
			true,                     // include legend
			true,                     // tooltips
			false                     // urls
		);
		
		// NOW DO SOME OPTIONAL CUSTOMISATION OF THE CHART...
		// set the background color for the chart...
		//	         final StandardLegend legend = (StandardLegend) chart.getLegend();
		//      legend.setAnchor(StandardLegend.SOUTH);
		chart.setBackgroundPaint(Color.white);
		
		/*
		final TextTitle subtitle = new TextTitle("서브타이틀.");
		
		subtitle.setFont(new Font("돋움", Font.PLAIN, 12));
		
		subtitle.setPosition(RectangleEdge.TOP);
		
		//subtitle.setSpacer(new Spacer(Spacer.RELATIVE, 0.05, 0.05, 0.05, 0.05));
		
		subtitle.setVerticalAlignment(VerticalAlignment.BOTTOM);
		
		chart.addSubtitle(subtitle);*/
		
		//제목
	    chart.getTitle().setFont(new Font("돋움", Font.BOLD, 15));
	    
	    //제목 히든
	    chart.getTitle().setText("");
	    
	    //범례
	    chart.getLegend().setItemFont(new Font("돋움", Font.PLAIN, 10));
	    
	    //범례 위치
        chart.getLegend().setPosition(RectangleEdge.BOTTOM);
        
        //범례 테두리 굵기
        chart.getLegend().setBorder(0, 0, 0, 0);
	     
	    CategoryPlot plot = chart.getCategoryPlot();
	     
	    Font font = plot.getDomainAxis().getLabelFont();
	    
	    //X축 라벨 Hidden
	    plot.getDomainAxis().setLabel(null);
	    
	    // X축 라벨
	    plot.getDomainAxis().setLabelFont(new Font("돋움", font.getStyle(), font.getSize()));
	    // X축 도메인
	    plot.getDomainAxis().setTickLabelFont(new Font("돋움", font.getStyle(), 10));
	    
	    font = plot.getRangeAxis().getLabelFont();
	    
	    //Y축 라벨 Hidden
	    plot.getRangeAxis().setLabel(null);
	    
	    // Y축 라벨
	    plot.getRangeAxis().setLabelFont(new Font("돋움", font.getStyle(), font.getSize()));
	    // Y축 범위
	    plot.getRangeAxis().setTickLabelFont(new Font("돋움", font.getStyle(), 10));
		
		//final CategoryPlot plot = chart.getCategoryPlot();
		
		plot.setForegroundAlpha(0.5f);
		
		//plot.setAxisOffset(new Spacer(Spacer.ABSOLUTE, 5.0, 5.0, 5.0, 5.0));
		plot.setBackgroundPaint(Color.lightGray);
		
		plot.setDomainGridlinesVisible(true);
		
		plot.setDomainGridlinePaint(Color.white);
		
		plot.setRangeGridlinesVisible(true);
		
		plot.setRangeGridlinePaint(Color.white);
		   
		final CategoryAxis domainAxis = plot.getDomainAxis();
		
		//X축 라벨 기울기
		//domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
		
		domainAxis.setLowerMargin(0.0);
		
		domainAxis.setUpperMargin(0.0);
		
		domainAxis.addCategoryLabelToolTip("Type 1", "The first type.");
		
		domainAxis.addCategoryLabelToolTip("Type 2", "The second type.");
		
		domainAxis.addCategoryLabelToolTip("Type 3", "The third type.");
		   
		final NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
		
		rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
		
		rangeAxis.setLabelAngle(0 * Math.PI / 2.0);
		
		AreaRenderer ar = (AreaRenderer) plot.getRenderer();
		
		ar.setSeriesPaint(0, c[0]);
		ar.setSeriesPaint(1, c[1]);
		
		// OPTIONAL CUSTOMISATION COMPLETED.
		   
		return chart;
	}
	
	 /**
     * Creates a sample chart.
     * 
     * @param dataset  the dataset.
     * 
     * @return A chart.
     */
	@SuppressWarnings("deprecation")
	private JFreeChart createPie3DChart(final PieDataset dataset, Color[] c, final int totalCount) {
        
        final JFreeChart chart = ChartFactory.createPieChart3D(
            "",  // chart title
            dataset,                // data
            true,                   // include legend
            true,
            false
        );
        
        //제목
	    chart.getTitle().setFont(new Font("돋움", Font.BOLD, 15));
	    //범례
	    chart.getLegend().setItemFont(new Font("돋움", Font.PLAIN, 15));

        final PiePlot3D plot = (PiePlot3D) chart.getPlot();
        plot.setStartAngle(290);
        plot.setLabelFont(new Font("돋움", Font.PLAIN, 12));
        plot.setDirection(Rotation.CLOCKWISE);
        plot.setForegroundAlpha(0.5f);
        plot.setNoDataMessage("No data to display");
        
        //plot.setSimpleLabels(true);
        
        plot.setLabelGenerator(new PieSectionLabelGenerator(){
        	@SuppressWarnings("rawtypes")
			public String generateSectionLabel(PieDataset aDataset, Comparable aKey) {
                String labelResult = null;
                if (aDataset != null)
                {
                   //화면에 보여질 text를 표시
                   labelResult = aKey.toString()+ "\n" + aDataset.getValue(aKey).intValue() + "개\n(" + Math.round(aDataset.getValue(aKey).doubleValue()/totalCount*100) + "%)";
            	}

            	return labelResult;
            }

            @SuppressWarnings("rawtypes")
			public AttributedString generateAttributedSectionLabel(PieDataset arg0, Comparable arg1) {
                  throw new UnsupportedOperationException("Not supported yet.");
            }
        });
        
        //백그라운드 컬러
        plot.setBackgroundPaint(Color.WHITE);
        
        //백그라운드 아웃라인 컬러
        plot.setOutlinePaint(Color.WHITE);
        
        //범례 위치
        chart.getLegend().setPosition(RectangleEdge.RIGHT);
        
        //범례 테두리 굵기
        chart.getLegend().setBorder(0, 0, 0, 0);
        
        //라벨 색상
        plot.setLabelBackgroundPaint(Color.WHITE);
        
        //라벨 굵기
        plot.setLabelOutlinePaint(Color.GRAY);
        
        //파이섹션 아웃라인 컬러
        //plot.setBaseSectionOutlinePaint(Color.WHITE);
        
        /*plot.setSectionPaint("자바", c[0]);
        plot.setSectionOutlinePaint("자바", c[0]);
        plot.setSectionPaint("Visual Basic", c[1]);
        plot.setSectionOutlinePaint("Visual Basic", c[1]);
        plot.setSectionPaint("C/C++", c[2]);
        plot.setSectionOutlinePaint("C/C++", c[2]);
        plot.setSectionPaint("PHP", c[3]);
        plot.setSectionOutlinePaint("PHP", c[3]);
        plot.setSectionPaint("펄", c[4]);
        plot.setSectionOutlinePaint("펄", c[4]);*/
        
        
        plot.setSectionPaint(0, c[0]);
        plot.setSectionOutlinePaint(0, c[0]);
        plot.setSectionPaint(1, c[1]);
        plot.setSectionOutlinePaint(1, c[1]);
        plot.setSectionPaint(2, c[2]);
        plot.setSectionOutlinePaint(2, c[2]);
        plot.setSectionPaint(3, c[3]);
        plot.setSectionOutlinePaint(3, c[3]);
        plot.setSectionPaint(4, c[4]);
        plot.setSectionOutlinePaint(4, c[4]);
        plot.setSectionPaint(5, c[5]);
        plot.setSectionOutlinePaint(5, c[5]);
        plot.setSectionPaint(6, c[6]);
        plot.setSectionOutlinePaint(6, c[6]);
        plot.setSectionPaint(7, c[7]);
        plot.setSectionOutlinePaint(7, c[7]);
        plot.setSectionPaint(8, c[8]);
        plot.setSectionOutlinePaint(8, c[8]);
        plot.setSectionPaint(9, c[9]);
        plot.setSectionOutlinePaint(9, c[9]);
		
        
        return chart;
    }
}
