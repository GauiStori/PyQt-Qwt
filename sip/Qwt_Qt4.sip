/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%Module(name=PyQt4.Qwt, keyword_arguments="Optional")

%Import QtCore/QtCoremod.sip
//typedef unsigned long size_t;
%Import QtGui/QtGuimod.sip
%Import QtOpenGL/QtOpenGLmod.sip
%Import QtSvg/QtSvgmod.sip

%Include conversions.sip
%Include qmap_convert.sip

%Include qwt_legend.sip
%Include qwt_legend_data.sip
%Include qwt_plot.sip
%Include qwt_plot_item.sip
%Include qwt_plot_layout.sip
%Include qwt_abstract_legend.sip
%Include qwt_scale_map.sip
%Include qwt_scale_engine.sip
%Include qwt_scale_div.sip
%Include qwt_scale_draw.sip
%Include qwt_abstract_scale_draw.sip
%Include qwt_interval.sip
%Include qwt_scale_widget.sip
%Include qwt_text.sip
%Include qwt_text_label.sip
%Include qwt_color_map.sip
%Include qwt_text_engine.sip


%Include qwt_picker.sip
%Include qwt_plot_picker.sip
%Include qwt_plot_zoomer.sip
%Include qwt_event_pattern.sip
%Include qwt_picker_machine.sip

%Include qwt_plot_canvas.sip

%Include qwt_plot_grid.sip

%Include qwt_plot_curve.sip
%Include qwt_plot_seriesitem.sip
%Include qwt_series_store.sip
%Include qwt_symbol.sip
%Include qwt_curve_fitter.sip
%Include qwt_samples.sip
%Include qwt_series_data.sip
%Include qwt_spline.sip

%Include qwt_plot_marker.sip

%Include qwt_panner.sip
%Include qwt_plot_panner.sip

%Include qwt_counter.sip

%Include qwt_column_symbol.sip
%Include qwt_plot_histogram.sip

%Include qwt_plot_barchart.sip
%Include qwt_plot_abstract_barchart.sip
%Include qwt_plot_multi_barchart.sip
%Include qwt_null_paintdevice.sip
%Include qwt_graphic.sip

%Include qwt_abstract_scale.sip
%Include qwt_abstract_slider.sip
%Include qwt_slider.sip

%Include qwt_thermo.sip

%Include qwt_wheel.sip

%Include qwt_round_scale_draw.sip
%Include qwt_knob.sip

%Include qwt_plot_directpainter.sip
%Include qwt_sampling_thread.sip
%Include qwt_plot_dict.sip

%Include qwt_plot_rasteritem.sip
%Include qwt_plot_spectrogram.sip
%Include qwt_raster_data.sip

%Include qwt_plot_renderer.sip
//%Include qwt_point_data.sip // Fails to compile


%Include qwt_slider.sip
%Include qwt_transform.sip

%Include qwt_dial_needle.sip
%Include qwt_dial.sip
%Include qwt_round_scale_draw.sip
%Include qwt_compass_rose.sip
%Include qwt_compass.sip

%Include qwt_point_polar.sip
%Include qwt_analog_clock.sip
%Include qwt_magnifier.sip
%Include qwt_plot_magnifier.sip
%Include qwt_arrow_button.sip
%Include qwt_plot_textlabel.sip
%Include qwt_legend_label.sip
%Include qwt_system_clock.sip
%Include qwt_date.sip
%Include qwt_dyngrid_layout.sip
%Include qwt_plot_glcanvas.sip
%Include qwt_plot_rescaler.sip
%Include qwt_widget_overlay.sip
%Include qwt_plot_shapeitem.sip
%Include qwt_matrix_raster_data.sip
%Include qwt_pixel_matrix.sip
%Include qwt_date_scale_engine.sip
%Include qwt_painter.sip
%Include qwt_plot_svgitem.sip
%Include qwt_interval_symbol.sip
%Include qwt_plot_spectrocurve.sip	
%Include qwt_plot_intervalcurve.sip
%Include qwt_plot_legenditem.sip
%Include qwt_painter_command.sip
%Include qwt_point_mapper.sip
%Include qwt_point_3d.sip
%Include qwt_date_scale_draw.sip
%Include qwt_plot_zoneitem.sip
%Include qwt_plot_scaleitem.sip
%Include qwt_clipper.sip
%Include qwt_plot_tradingcurve.sip
