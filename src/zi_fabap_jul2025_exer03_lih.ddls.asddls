@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Views ex3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FABAP_JUL2025_EXER03_LIH 
    as select from /dmo/customer as Customer
    
{
    key Customer.customer_id as CustomerID,
        Customer.first_name as FistName,
        Customer.last_name as LastName,
        Customer.street as Street,
        Customer.country_code as CountryCode,
        Customer.city as City,
        
        
    concat_with_space(
    concat_with_space(
    concat(street, ','), city, 1 ),
    concat_with_space( '–', Customer.country_code, 1 ),  1                                                 
                     ) as FullAddress
    
}
