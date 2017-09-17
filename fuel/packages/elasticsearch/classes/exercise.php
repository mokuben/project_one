<?php

namespace Packages\Elasticsearch;

final class Exercise extends \Packages\Elasticsearch\Base
{
    protected $client = null;

    public function __construct()
    {
        $hosts = ['http://10.0.2.2'];//ローカルOSからホストOSで動くESに接続するため。
        $this->client = parent::connect($hosts);
    }

    public function searchTest()
    {
        $params['body'] = [
            'query' => [
                'query_string' => [
                    'query' => 'match_all',
                ]
            ],
        ];

        $results = $this->client->search($params);
        var_dump($results);exit;


    }

    public function infoTest()
    {
        $params = [
            'client' => ['timeout' => 1],
        ];
        $response = $this->client->info($params);
        var_dump($response);exit;

    }

}