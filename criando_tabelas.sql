--------------------------------
-- Criando as tabelas:
--------------------------------
 -- Motoristas
create table drivers (driver_id varchar(12) primary key,
 first_name varchar(19) not null,
 last_name varchar (19) not null,
 hire_date DATE, 
 termination_date DATE, 
 license_number varchar(15),
 license_state varchar(2), 
 date_of_birth DATE,
 home_terminal varchar(20),
 employment_status varchar(12),
 cdl_class varchar(5),
 years_experience int);

 -- Caminhões
create table trucks(truck_id varchar(12) primary key,
 unit_number varchar(4),
 make varchar(15),
 model_year int,
 vin varchar(19),
 acquisition_date DATE,
 acquisition_mileage int,
 fuel_type varchar(10),
 tank_capacity_gallons int,
 status varchar(11),
 home_terminal varchar(14));

-- Reboque/Carreta 
create table trailers(trailer_id varchar (12) primary key,
 trailer_number varchar(5),
 trailer_type varchar(13),
 length_feet int,
 model_year int,
 vin varchar(19),
 acquisition_date DATE,
 status varchar(15),
 current_location varchar(14));

 -- Fabricante
create table customers(customer_id varchar(12) primary key,
 customer_name varchar(30),
 customer_type varchar(15),
 credit_terms_days int,
 primary_freight_type varchar(15),
 account_status varchar(10),
 contract_start_date DATE,
 annual_revenue_potential int);

 --Intalações
create table facilities(facility_id varchar(12)primary key,
 facility_name varchar(33),
 facility_type varchar(20),
 city varchar(20),
 uf_state varchar(2),
 latitude decimal(8,6),
 longitude decimal(9,6),
 dock_doors int,
 operating_hours varchar(10));

 --Rotas
create table routes(route_id varchar(12) primary key,
  origin_city varchar(20),
  origin_state varchar (2),
  destination_city varchar(20),
  destination_state varchar(2),
  typical_distance_miles int,
  base_rate_per_mile decimal(3,2),
  fuel_surcharge_rate decimal(3,2),
  typical_transit_days int);
  
-- Carga
create table loads(load_id varchar(12) primary key,
 customer_id varchar(10),
 route_id varchar(10),
 load_date DATE,
 load_type varchar(13),
 weight_lbs int,
 pieces int,
 revenue decimal(6,2),
 fuel_surcharge decimal(5,2),
 accessorial_charges int,
 load_status varchar (15),
 booking_type varchar(15),
-- Definido restrições 1 fk
 constraint fk_customer foreign key (customer_id) references customers(customer_id),
 -- Definido restrições 2 fk
 constraint fk_route foreign key (route_id) references routes(route_id));

-- Viagens 
create table trips(trip_id varchar(13) primary key,
 load_id varchar (12),
 driver_id varchar (12),
 truck_id varchar (12),
 trailer_id varchar (12),
 dispatch_date DATE,
 actual_distance_miles int,
 actual_duration_hours decimal(4,2),
 fuel_gallons_used decimal(4,1),
 average_mpg decimal(3,2),
 idle_time_hours decimal(3,1),
 trip_status varchar(15),
 -- definido a 1º restrição
 constraint fk_load foreign key (load_id) references loads (load_id),
 -- definido a 2º restrição
 constraint fk_driver foreign key (driver_id) references Drivers (driver_id),
 -- definido a 3º restrição
 constraint fk_truck foreign key (truck_id) references trucks(truck_id),
 -- definido a 4º restrição
 constraint fk_trailer foreign key (trailer_id) references trailers(trailer_id)
 );

-- Abastecimento
create table fuel_purchases(fuel_purchase_id varchar(13) primary key,
 trip_id varchar (13),
 truck_id varchar (12),
 driver_id varchar (12),
 purchase_date TIMESTAMP,
 location_city varchar(20),
 location_state varchar(2),
 gallons decimal(4,1),
 price_per_gallon decimal(4,3),
 total_cost decimal(5,2),
 fuel_card_number varchar(10),
 -- definido a 1º restrição
 constraint fk_trip foreign key (trip_id) references trips(trip_id),
 -- definido a 2º restrição
 constraint fk_truck foreign key (truck_id) references trucks(truck_id),
 -- definido a 3º restrição
 constraint fk_driver foreign key (driver_id) references Drivers (driver_id)
 );

--Manutenção
create table maintenance_records(maintenance_id varchar(14) primary key,
 truck_id varchar (12),
 maintenance_date DATE,
 maintenance_type varchar(14),
 odometer_reading int,
 labor_hours decimal(3,1),
 labor_cost decimal(5,2),
 parts_cost decimal(6,2),
 total_cost decimal(6,2),
 facility_location varchar(23),
 downtime_hours decimal(4,1),
 service_description varchar(25),
 -- definido a restrição
 constraint fk_truck foreign key (truck_id) references trucks(truck_id)
 );

 --Eventos de entrega
create table delivery_events(event_id varchar(12) primary key,
 load_id varchar (12),
 trip_id varchar (13),
 event_type varchar(15),
 facility_id varchar(12) ,
 scheduled_datetime TIMESTAMPTZ,
 actual_datetime TIMESTAMPTZ,
 detention_minutes int,
 on_time_flag BOOLEAN,
 location_city varchar(20),
 location_state varchar(2),
 -- definido a 1º restrição
 constraint fk_load foreign key (load_id) references loads (load_id),
 -- definido a 2º restrição
 constraint fk_trip foreign key (trip_id) references trips(trip_id),
 -- definido a 3º restrição
 constraint fk_facility foreign key (facility_id) references facilities(facility_id)
 );

 --incidentes de segurança
create table safety_incidents(incident_id varchar(12) primary key,
 trip_id varchar (13),
 truck_id varchar (12),
 driver_id varchar (12),
 incident_date TIMESTAMP,
 incident_type varchar(23),
 location_city varchar(20),
 location_state varchar(2),
 at_fault_flag BOOLEAN,
 injury_flag BOOLEAN,
 vehicle_damage_cost decimal(7,2),
 cargo_damage_cost decimal(8,2),
 claim_amount decimal(7,2),
 preventable_flag BOOLEAN,
 description varchar(45),
 -- definido a 1º restrição
 constraint fk_trip foreign key (trip_id) references trips(trip_id),
 -- definido a 2º restrição
 constraint fk_truck foreign key (truck_id) references trucks(truck_id),
 -- definido a 3º restrição
 constraint fk_driver foreign key (driver_id) references Drivers (driver_id)
 );