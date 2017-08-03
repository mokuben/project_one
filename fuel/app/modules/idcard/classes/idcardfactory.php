<?php
/**
 * Created by PhpStorm.
 * User: lai
 * Date: 2017/08/03
 * Time: 20:40
 */

namespace Idcard;

class Idcardfactory extends \Factory
{
    /**
     * @var array
     */
    private $owners = [];

    protected function __construct()
    {
        \Log::error('ID Card工場を作りました！');
    }

    protected function createProduct($owner)
    {
        return new IDCard($owner);
    }

    protected function registerProduction($idCard)
    {
        $this->owners[] = $idCard->getOwner();
    }

    public function getOwners()
    {
        return $this->owners;
    }
}