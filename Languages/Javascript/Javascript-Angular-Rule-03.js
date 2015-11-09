// Javascript - Angular (Rule 03)
(function ($angular) {
    function myController ($scope) {
        ...
    }
 
    $angular.module('myModule')
        .controller('myController', '$scope', myController)
    ;
}) (angular);