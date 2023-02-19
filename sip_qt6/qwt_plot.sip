/* 
 * python-qwt. Python wrapper for the Qwt Widget Library
 * Copyright (C) 1997   Josef Wilgen
 * Copyright (C) 2002   Uwe Rathmann
 * Copyright (C) 2015   Gudjon I. Gudjonsson
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the Qwt License, Version 1.0
 *****************************************************************************/

%If(- Qwt_6_1_6)
class QwtPlot: QFrame , QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot.h>
%End
public:
    //! \brief Axis index
    enum Axis
    {
        //! Y axis left of the canvas
        yLeft,

        //! Y axis right of the canvas
        yRight,

        //! X axis below the canvas
        xBottom,

        //! X axis above the canvas
        xTop,

        //! Number of axes
        axisCnt
    };

    /*!
        Position of the legend, relative to the canvas.

        \sa insertLegend()
     */
    enum LegendPosition
    {
        //! The legend will be left from the QwtPlot::yLeft axis.
        LeftLegend,

        //! The legend will be right from the QwtPlot::yRight axis.
        RightLegend,

        //! The legend will be below the footer 
        BottomLegend,

        //! The legend will be above the title
        TopLegend
    };

    explicit QwtPlot( QWidget * /TransferThis/ = NULL );
    explicit QwtPlot( const QwtText &title, QWidget * /TransferThis/ = NULL );

    virtual ~QwtPlot();

    void applyProperties( const QString & );
    QString grabProperties() const;

    void setAutoReplot( bool = true );
    bool autoReplot() const;

    // Layout

    void setPlotLayout( QwtPlotLayout * );

    QwtPlotLayout *plotLayout();
    //const QwtPlotLayout *plotLayout() const;

    // Title

    void setTitle( const QString & );
    void setTitle( const QwtText &t );
    QwtText title() const;

    QwtTextLabel *titleLabel();
    //const QwtTextLabel *titleLabel() const;

    // Footer

    void setFooter( const QString & );
    void setFooter( const QwtText &t );
    QwtText footer() const;

    QwtTextLabel *footerLabel();
    //const QwtTextLabel *footerLabel() const;

    // Canvas

    void setCanvas( QWidget * /Transfer/);

    QWidget *canvas();
    //const QWidget *canvas() const;

    void setCanvasBackground( const QBrush & );
    QBrush canvasBackground() const;

    virtual QwtScaleMap canvasMap( int axisId ) const;

    double invTransform( int axisId, int pos ) const;
    double transform( int axisId, double value ) const;

    // Axes

    QwtScaleEngine *axisScaleEngine( int axisId );
    //const QwtScaleEngine *axisScaleEngine( int axisId ) const;
    void setAxisScaleEngine( int axisId, QwtScaleEngine * /Transfer/);

    void setAxisAutoScale( int axisId, bool on = true );
    bool axisAutoScale( int axisId ) const;

    void enableAxis( int axisId, bool tf = true );
    bool axisEnabled( int axisId ) const;

    void setAxisFont( int axisId, const QFont &f );
    QFont axisFont( int axisId ) const;

    void setAxisScale( int axisId, double min, double max, double step = 0 );
    void setAxisScaleDiv( int axisId, const QwtScaleDiv & );
    void setAxisScaleDraw( int axisId, QwtScaleDraw *  /Transfer/);

    double axisStepSize( int axisId ) const;
    QwtInterval axisInterval( int axisId ) const;

    const QwtScaleDiv &axisScaleDiv( int axisId ) const;

    //const QwtScaleDraw *axisScaleDraw( int axisId ) const;
    QwtScaleDraw *axisScaleDraw( int axisId );

    //const QwtScaleWidget *axisWidget( int axisId ) const;
    QwtScaleWidget *axisWidget( int axisId );

    void setAxisLabelAlignment( int axisId, Qt::Alignment );
    void setAxisLabelRotation( int axisId, double rotation );

    void setAxisTitle( int axisId, const QString & );
    void setAxisTitle( int axisId, const QwtText & );
    QwtText axisTitle( int axisId ) const;

    void setAxisMaxMinor( int axisId, int maxMinor );
    int axisMaxMinor( int axisId ) const;

    void setAxisMaxMajor( int axisId, int maxMajor );
    int axisMaxMajor( int axisId ) const;

    // Legend

    void insertLegend( QwtAbstractLegend * /Transfer/, LegendPosition = QwtPlot::RightLegend, double ratio = -1.0 );

    QwtAbstractLegend *legend();
    //const QwtAbstractLegend *legend() const;

    void updateLegend();
    void updateLegend( const QwtPlotItem *);

    // Misc

    virtual QSize sizeHint() const;
    virtual QSize minimumSizeHint() const;

    virtual void updateLayout();
    virtual void drawCanvas( QPainter * );

    void updateAxes();
    void updateCanvasMargins();

    virtual void getCanvasMarginsHint( 
        const QwtScaleMap *, const QRectF &canvasRect,
        double &left, double &top, double &right, double &bottom) const;

    virtual bool event( QEvent * );
    virtual bool eventFilter( QObject *, QEvent *);

    virtual void drawItems( QPainter *, const QRectF &,
        const QwtScaleMap * ) const;

    virtual QVariant itemToInfo( QwtPlotItem *) const;
    virtual QwtPlotItem *infoToItem( const QVariant & ) const;

signals:
    /*!
      A signal indicating, that an item has been attached/detached

      \param plotItem Plot item
      \param on Attached/Detached
     */
    void itemAttached( QwtPlotItem *plotItem, bool on );

    /*!
      A signal with the attributes how to update 
      the legend entries for a plot item.

      \param itemInfo Info about a plot item, build from itemToInfo()
      \param data Attributes of the entries ( usually <= 1 ) for
                  the plot item.

      \sa itemToInfo(), infoToItem(), QwtAbstractLegend::updateLegend()
     */
    void legendDataChanged( const QVariant &itemInfo, 
        const QList<QwtLegendData> &data );

public slots:
    virtual void replot();
    void autoRefresh();

protected:
    static bool axisValid( int axisId );

    virtual void resizeEvent( QResizeEvent *e );

private slots:
    void updateLegendItems( const QVariant &itemInfo,
        const QList<QwtLegendData> &data );

/*private:
    friend class QwtPlotItem;
    void attachItem( QwtPlotItem *, bool );

    void initAxesData();
    void deleteAxesData();
    void updateScaleDiv();

    void initPlot( const QwtText &title );

    class AxisData;
    AxisData *d_axisData[axisCnt];

    class PrivateData;
    PrivateData *d_data;*/
};
%End // (- Qwt_6_1_6)

%If(Qwt_6_2_0 -)
class QwtPlot : QFrame, QwtPlotDict
{
%TypeHeaderCode
#include <qwt_plot.h>
%End
    //Q_OBJECT

    /*Q_PROPERTY( QBrush canvasBackground
        READ canvasBackground WRITE setCanvasBackground )

    Q_PROPERTY( bool autoReplot READ autoReplot WRITE setAutoReplot )*/

  public:
//#if QWT_AXIS_COMPAT
    enum Axis
    {
        yLeft   = QwtAxis::YLeft,
        yRight  = QwtAxis::YRight,
        xBottom = QwtAxis::XBottom,
        xTop    = QwtAxis::XTop,

        axisCnt = QwtAxis::AxisPositions
    };

    void enableAxis( int q, bool on = true );

    bool axisEnabled( int axisId ) const;
//#endif
    enum LegendPosition
    {
        LeftLegend,
        RightLegend,
        BottomLegend,
        TopLegend
    };

    explicit QwtPlot( QWidget* /TransferThis/ = NULL );
    explicit QwtPlot( const QwtText& title, QWidget* /TransferThis/ = NULL );

    virtual ~QwtPlot();

    void setAutoReplot( bool = true );
    bool autoReplot() const;

    // Layout

    void setPlotLayout( QwtPlotLayout* );

    QwtPlotLayout* plotLayout();
    //const QwtPlotLayout* plotLayout() const;

    // Title

    void setTitle( const QString& );
    void setTitle( const QwtText& );
    QwtText title() const;

    QwtTextLabel* titleLabel();
    //const QwtTextLabel* titleLabel() const;

    // Footer

    void setFooter( const QString& );
    void setFooter( const QwtText& );
    QwtText footer() const;

    QwtTextLabel* footerLabel();
    //const QwtTextLabel* footerLabel() const;

    // Canvas

    void setCanvas( QWidget* /Transfer/);

    QWidget* canvas();
    //const QWidget* canvas() const;

    void setCanvasBackground( const QBrush& );
    QBrush canvasBackground() const;

    virtual QwtScaleMap canvasMap( int ) const;

    double invTransform( int, double pos ) const;
    double transform( int, double value ) const;

    // Axes

    bool isAxisValid( int ) const;

    void setAxisVisible( int, bool on = true );
    bool isAxisVisible( int ) const;

    // Axes data

    QwtScaleEngine* axisScaleEngine( int );
    //const QwtScaleEngine* axisScaleEngine( int ) const;
    void setAxisScaleEngine( int, QwtScaleEngine* /Transfer/);

    void setAxisAutoScale( int, bool on = true );
    bool axisAutoScale( int ) const;

    void setAxisFont( int, const QFont& );
    QFont axisFont( int ) const;

    void setAxisScale( int, double min, double max, double stepSize = 0 );
    void setAxisScaleDiv( int, const QwtScaleDiv& );
    void setAxisScaleDraw( int, QwtScaleDraw* /Transfer/);

    double axisStepSize( int ) const;
    QwtInterval axisInterval( int ) const;
    const QwtScaleDiv& axisScaleDiv( Axis ) const;

    //const QwtScaleDraw* axisScaleDraw( int ) const;
    QwtScaleDraw* axisScaleDraw( Axis );

    //const QwtScaleWidget* axisWidget( int ) const;
    QwtScaleWidget* axisWidget( Axis );

    void setAxisLabelAlignment( Axis, Qt::Alignment );
    void setAxisLabelRotation( Axis, double rotation );

    void setAxisTitle( Axis, const QString& );
    void setAxisTitle( Axis, const QwtText& );
    QwtText axisTitle( Axis ) const;

    void setAxisMaxMinor( Axis, int maxMinor );
    int axisMaxMinor( Axis ) const;

    void setAxisMaxMajor( Axis, int maxMajor );
    int axisMaxMajor( Axis ) const;

    // Legend

    void insertLegend( QwtAbstractLegend*,
        LegendPosition = QwtPlot::RightLegend, double ratio = -1.0 );

    QwtAbstractLegend* legend();
    //const QwtAbstractLegend* legend() const;

    void updateLegend();
    void updateLegend( const QwtPlotItem* );

    // Misc

    virtual QSize sizeHint() const ; // QWT_OVERRIDE;
    virtual QSize minimumSizeHint() const ; // QWT_OVERRIDE;

    virtual void updateLayout();
    virtual void drawCanvas( QPainter* );

    void updateAxes();
    void updateCanvasMargins();

    /*virtual void getCanvasMarginsHint(
        const QwtScaleMap maps[], const QRectF& canvasRect,
        double& left, double& top, double& right, double& bottom) const; FIXME*/

    virtual bool event( QEvent* ) ; // QWT_OVERRIDE;
    virtual bool eventFilter( QObject*, QEvent* ) ; // QWT_OVERRIDE;

    /*virtual void drawItems( QPainter*, const QRectF&,
        const QwtScaleMap maps[ QwtAxis::AxisPositions ] ) const;FIXME*/

    virtual QVariant itemToInfo( QwtPlotItem* ) const;
    virtual QwtPlotItem* infoToItem( const QVariant& ) const;

  Q_SIGNALS:
    void itemAttached( QwtPlotItem* plotItem, bool on );
    void legendDataChanged( const QVariant& itemInfo,
        const QList< QwtLegendData >& data );

  public Q_SLOTS:
    virtual void replot();
    void autoRefresh();

  protected:

    virtual void resizeEvent( QResizeEvent* ) ; // QWT_OVERRIDE;

  private Q_SLOTS:
    void updateLegendItems( const QVariant& itemInfo,
        const QList< QwtLegendData >& legendData );

/*  private:
    friend class QwtPlotItem;
    void attachItem( QwtPlotItem*, bool );

    void initAxesData();
    void deleteAxesData();
    void updateScaleDiv();

    void initPlot( const QwtText& title );

    class ScaleData;
    ScaleData* m_scaleData;

    class PrivateData;
    PrivateData* m_data;*/
};
%End // (- Qwt_6_2_0)
