/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/
%Module(name=Qwt, keyword_arguments="Optional")

%Import QtCore/QtCoremod.sip
//%DefaultSupertype sip.simplewrapper
//%Module Qwt
typedef unsigned long size_t;

%Import QtGui/QtGuimod.sip

%If (Qt_5_0_0 -)
%Import QtWidgets/QtWidgetsmod.sip
%End

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


%Include qwt_series_data.sip
%Include qwt_plot_seriesitem.sip
%Include qwt_series_store.sip
%Include qwt_plot_curve.sip

%Include qwt_plot_grid.sip

%Include qwt_symbol.sip

%Include qwt_column_symbol.sip
%Include qwt_samples.sip
%Include qwt_plot_histogram.sip

%Include qwt_plot_canvas.sip

%Include qwt_spline.sip
%Include qwt_curve_fitter.sip

%Include qwt_event_pattern.sip
%Include qwt_picker_machine.sip
%Include qwt_picker.sip
%Include qwt_plot_picker.sip
%Include qwt_plot_zoomer.sip

%Include qwt_text_engine.sip
%Include qwt_text.sip
%Include qwt_text_label.sip
%Include qwt_plot_marker.sip

%Include qwt_panner.sip
%Include qwt_plot_panner.sip

/* It works until here */
/*
%Include QwtArrayDouble.sip
%Include qwt_color_map.sip
%Include QwtList.sip
%Include qwt_scale_engine.sip
%Include qwt_text_label.sip
%Include qwt_text_engine.sip
%Include qwt_text.sip
%Include qwt_plot_dict.sip
*/

//%Include qwt_legend_itemmanager.sip
//%Include qwt_legend_item.sip
