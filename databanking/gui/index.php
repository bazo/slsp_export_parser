<?php

header('Content-Type: text/plain; charset=utf-8');

$xml = simplexml_load_file("../data/obraty.xml");

foreach($xml->children() as $first) {
#  echo $first->getName() . " " . $first . "<br />";
  foreach ($first->children() as $second) {
#    echo $second->getName() . " " . $second . "<br />";
    foreach ($second->children() as $third) {
#      echo $third->getName() . " " . $third . "<br />";
      echo "\n";
      foreach ($third->children() as $fourth) {
#        echo $fourth->getName() . " " . $fourth . ";";
	echo $fourth.";";
      }
    }
  }
}
?>
