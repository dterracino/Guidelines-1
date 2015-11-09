// Javascript - Angular (Rule 02)
(function ($angular) {
    function myController($scope) {
        ...
    }
        
    function myDirective ($scope) {
        ...
    }
         
    $angular.module('myModule')
      .directive('myDirective', ['$scope', myDirective])
      .controller('myController', ['$scope', myController])
    ;
})(angular);