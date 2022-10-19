use my_db;

ALTER TABLE `stations`
MODIFY `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(id);
-- Para agregar una llave foranea
-- ADD CONSTRAINT `trains_line_id_foreign`
-- FOREIGN KEY (`line_id`) REFERENCES `lines`(`id`);
