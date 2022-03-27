CREATE DATABASE grocery_store;

CREATE TABLE `grocery_store`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `uom_id` INT NOT NULL,
  `price_per_unit` DOUBLE NOT NULL,
  PRIMARY KEY (`product_id`));

INSERT INTO `grocery_store`.`products` (`product_id`, `name`, `uom_id`, `price_per_unit`) VALUES ('10', 'potato', '1', '20');
INSERT INTO `grocery_store`.`products` (`product_id`, `name`, `uom_id`, `price_per_unit`) VALUES ('11', 'egg', '12', '90');


CREATE TABLE `grocery_store`.`uom` (
  `uom_id` INT NOT NULL AUTO_INCREMENT,
  `uom_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`uom_id`));

INSERT INTO `grocery_store`.`uom` (`uom_id`, `uom_name`) VALUES ('1', 'each');
INSERT INTO `grocery_store`.`uom` (`uom_id`, `uom_name`) VALUES ('2', 'kg');


ALTER TABLE `grocery_store`.`products` 
ADD INDEX `fk_uom_id_idx` (`uom_id` ASC) VISIBLE;
;

ALTER TABLE `grocery_store`.`products` 
ADD CONSTRAINT `fk_uom_id`
  FOREIGN KEY (`uom_id`)
  REFERENCES `grocery_store`.`uom` (`uom_id`)
  ON DELETE NO ACTION
  ON UPDATE RESTRICT;

CREATE TABLE `grocery_store`.`orders` (
  `orders_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(100) NOT NULL,
  `total` DOUBLE NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`orders_id`));

INSERT INTO `grocery_store`.`orders` (`orders_id`, `customer_name`, `total`, `datetime`) VALUES ('1', 'Jahid', '300', '20220327');

CREATE TABLE `grocery_store`.`order_details` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  `total_price` DOUBLE NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `grocery_store`.`orders` (`orders_id`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `grocery_store`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT);

INSERT INTO `grocery_store`.`order_details` (`order_id`, `product_id`, `quantity`, `total_price`) VALUES ('1', '1', '1', '60');

CREATE  OR REPLACE VIEW `info` AS (
select o.customer_name, p.name, od.quantity, od.total_price, o.datetime
from order_details as od
join products as p on od.product_id = p.product_id
join orders as o on o.orders_id = od.order_id);


select o.customer_name, p.name, od.quantity, od.total_price, o.datetime
from order_details as od
join products as p on od.product_id = p.product_id
join orders as o on o.orders_id = od.order_id;


update products set name = 'mango' where product_id = 9;

delete from products where product_id = 8;




