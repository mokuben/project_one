<?php
/**
 * Created by PhpStorm.
 * User: kakehi
 * Date: 2017/09/03
 * Time: 18:42
 */

//require('/Users/kakehi/kaki-cl/project_one/fuel/vendor/elasticsearch/elasticsearch/src/Elasticsearch/ClientBuilder.php');

require '/Users/kakehi/kaki-cl/project_one/fuel/vendor/autoload.php';
//use Elasticsearch\ClientBuilder;


$hosts = ['http://localhost:9200'];
$client = \Elasticsearch\ClientBuilder::create()->setHosts($hosts)->build();


$params['body'] = [
    'query' => [
        'query_string' => [
            'query' => 'match_all',
        ]
    ],
];




$results = $client->search($params);
var_dump($results);



//$params = [
//    'client' => ['timeout' => 1],
//];
//$response = $client->info($params);
//var_dump($response);