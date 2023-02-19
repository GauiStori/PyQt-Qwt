%If(Qwt_6_2_0 -)
class QwtWeedingCurveFitter : QwtCurveFitter /NoDefaultCtors/
{
%TypeHeaderCode
#include <qwt_weeding_curve_fitter.h>
%End
  public:
    explicit QwtWeedingCurveFitter( double tolerance = 1.0 );
    virtual ~QwtWeedingCurveFitter();

    void setTolerance( double );
    double tolerance() const;

    void setChunkSize( uint );
    uint chunkSize() const;

    virtual QPolygonF fitCurve( const QPolygonF& ) const; // QWT_OVERRIDE;
    virtual QPainterPath fitCurvePath( const QPolygonF& ) const; // QWT_OVERRIDE;

};
%End // (Qwt_6_2_0 -)
