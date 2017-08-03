<?php

/**
 * Created by PhpStorm.
 * User: lai
 * Date: 2017/08/03
 * Time: 20:18
 */
abstract class Factory
{
    /**
     * @var null
     */
    protected static $instance = null;

    public static function getInstance()
    {
        if (empty(static::$instance)) {
            static::$instance = new static();
        }
        return static::$instance;
    }
    protected abstract function __construct();

    public final function create($owner)
    {
        $product = $this->createProduct($owner);
        $this->registerProduction($product);
        return $product;
    }

    protected abstract function createProduct($owner);
    protected abstract function registerProduction($product);
}