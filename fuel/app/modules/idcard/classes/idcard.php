<?php
namespace Idcard;

/**
 * Created by PhpStorm.
 * User: lai
 * Date: 2017/08/03
 * Time: 20:32
 */
class IDCard extends \Product
{
    /**
     * @var string
     */
    private $owner = '';

    public function __construct($owner)
    {
        \Log::error($owner . 'のカードを作りました！');
        $this->owner = $owner;

    }

    public function useProduct()
    {
        \Log::error($this->owner . 'のカードを使いました！');
    }

    public function getOwner()
    {
        return $this->owner;
    }
}