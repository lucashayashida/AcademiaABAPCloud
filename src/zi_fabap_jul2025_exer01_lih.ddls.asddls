@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exercício 01 - CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_JUL2025_EXER01_LIH 
    as select from /dmo/flight as Flight
    inner join /dmo/carrier as Carrier on Flight.carrier_id = Carrier.carrier_id
{
    
    key Flight.carrier_id as CarrierID,
        Flight.connection_id as ConnectionID, 
        Flight.flight_date as FlightDate,
        
        Flight.seats_max as MaxSeat,
        Flight.seats_occupied as OccupiedSeat,
        Carrier.name as CarrierName,
        
        
    concat( cast (
               cast( ( Flight.seats_occupied / Flight.seats_max ) * 100 as abap.dec( 8, 2 )
                  ) as abap.char( 10 ) ),
                   '%' ) as OccupancyRate
    
   
         
}
    
