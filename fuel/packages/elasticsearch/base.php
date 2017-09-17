<?php

namespace Packages\Elasticsearch;

abstract class Base
{
    protected function connect($hosts)
    {
        try {
            $client = \Elasticsearch\ClientBuilder::create()
                ->setHosts($hosts)
                ->build();
            return $client;
        } catch (\Exception $ex) {
            return false;
        }
    }

}
