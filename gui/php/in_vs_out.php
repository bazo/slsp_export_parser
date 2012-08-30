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
	if ($total > 40000) { $total = $total - 50000; };
	if ($total < -10000) { $total = $total + 50000; };
	$sum['amount'][] = $total;
	$sum['date'][] = $d['date']+$i++;
}

require_once ('jpgraph-3.5.0b1/src/jpgraph.php');
require_once ('jpgraph-3.5.0b1/src/jpgraph_scatter.php');
require_once ('jpgraph-3.5.0b1/src/jpgraph_date.php');

$graph = new Graph(1200,700);
$graph->SetScale("datlin");
$graph->xaxis->SetTextLabelInterval(2);
 
$graph->img->SetMargin(70,40,40,40);        
$graph->SetShadow();
 
$sp1 = new ScatterPlot($sum['amount'],$sum['date']);
$sp1->mark->Hide();
$sp1->link->Show();
 
$graph->Add($sp1);
$graph->Stroke();

?>
