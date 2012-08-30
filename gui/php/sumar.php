<?php
include("db.php");

$raw = mysql_query("SELECT * FROM `transactions`
			LEFT JOIN `transactions_categorys` 
			ON `transactions`.`transaction_id`=`transactions_categorys`.`transaction_id`
			LEFT JOIN `categorys` 
			ON `categorys`.`category_id`=`transactions_categorys`.`category_id`
			ORDER BY `transactions`.`date`");

$out = 0;
$in = 0;
$total = 0;
$i = 0;
while ($d = mysql_fetch_array($raw,MYSQL_ASSOC)) {
	$total = $total+$d['amount'];
	$sum[$d['date']+$i++][] = $total;
}


?>
<pre>
<?
print_r($sum);
?>
