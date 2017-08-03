<?php
namespace Idcard;

/**
 * Created by PhpStorm.
 * User: lai
 * Date: 2017/08/03
 * Time: 20:50
 */
class Controller_Factory extends \Controller
{
    public function action_index()
    {
        $idCardFactory = Idcardfactory::getInstance();
        $card1 = $idCardFactory->create('ライ');
        $card2 = $idCardFactory->create('近江');
        $card3 = $idCardFactory->create('チョービュー');
        $card1->useProduct();
        $card2->useProduct();
        $card3->useProduct();
        return \Response::forge(\View::forge('welcome/index'));
    }
}