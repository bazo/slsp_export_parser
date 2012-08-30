<html>
<head>
<style>
body {
	margin: 0px;
	margin-left: 10px;
	margin-top: 20px;
	margin-bottom: 30px;
}
table, tr, td {
	border: 1px solid;
	border-collapse:collapse;
	font-family: Verdana, sans-serif;
	font-size: 10pt;
}
.red {
	background: #FFAD99;
}

.green {
	background: #94FF94;
}
.vyber_kartou {
	background: #DF013A;
}
.platba_kartou {
	background: #AA0000;
}
</style>
</head>
<body>
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
echo '<table border=1>'."\n";
while ($d = mysql_fetch_array($raw,MYSQL_ASSOC)) {
	if (preg_match("/V.ber kartou/", $d['info'])) {
		$class = 'vyber_kartou';
	} elseif (preg_match("/Platba kartou/", $d['info'])) {
		$class = 'platba_kartou';
	} elseif ($d['amount']>=0) {
                $class = "green";
        } else {
		$class = "";
	}
	echo '<tr class='.$class.'><td>'.date("d. M y",$d['date']).'</td><td>'.$d['amount'].'</td><td>'.$d['info'].'</td></tr>'."\n";
}
echo '</table>';
?>
