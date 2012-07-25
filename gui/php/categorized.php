<pre>
<?php
include("db.php");

$raw = mysql_query("SELECT * FROM `transactions`
			JOIN `transactions_categorys` 
			ON `transactions`.`transaction_id`=`transactions_categorys`.`transaction_id`
			JOIN `categorys` 
			ON `categorys`.`category_id`=`transactions_categorys`.`category_id`");
while ($row = mysql_fetch_array($raw,MYSQL_ASSOC)) {
	print_r($row);
}
