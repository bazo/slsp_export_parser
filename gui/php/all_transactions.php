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
echo '<table border=1>';
while ($d = mysql_fetch_array($raw,MYSQL_ASSOC)) {
	if ($d['amount']>=0) {
		$in = $in+$d['amount'];
	}
	if ($d['amount']<=0) {
		$out = $out+abs($d['amount']);
	}
	echo '<tr><td>'.date("d. M y",$d['date']).'</td><td>'.$d['amount'].'</td><td>'.$d['info'].'</td></tr>';
}
echo '</table>';
echo "Total in: $in<br>Total out: $out";
?>
