(function (){
    'use strict';

    angular
        .module('app.components')
        .directive('ionicSelect', ionicSelect);

    ionicSelect.$inject = ['$ionicModal'];

    function ionicSelect($ionicModal) {
        return {
            restrict: 'E',

            template: function(element, attrs) {
                if (attrs.templateUrl) {
                    return '<ng-include src="\'' + attrs.templateUrl + '\'"></ng-include>';
                } else {
                    return '<ion-list> <ion-item ng-click=showItems($event)> {{text}} <span class=item-note>{{noteText}} <img class={{noteImgClass}} ng-if="noteImg != null" src="{{noteImg}}"/> </span> </ion-item> </ion-list>';
                }
            },

            scope: {
                items: '=',
                value: '=',
                error: '=',
                valueChangedCallback: '&valueChanged', // the callback used to signal that the value has changed
                getCustomTextCallback: '&getCustomText' // the callback used to get custom text based on the selected value
            },

            // hook up the directive
            link: function(scope, element, attrs) {
                // default values
                scope.multiSelect = attrs.multiSelect === 'true' ? true : false;
                scope.allowEmpty = attrs.allowEmpty === 'false' ? false : true;
                scope.required = attrs.required === 'true' ? true : false;

                // header used in ion-header-bar
                scope.headerText = attrs.headerText || '';

                // text displayed on label
                scope.text = attrs.text || '';
                scope.defaultText = attrs.text || '';

                // data binding properties
                scope.checkedProperty = attrs.checkedProperty || 'checked';
                scope.iconProperty = attrs.iconProperty || 'icon';
                scope.textProperty = attrs.textProperty || 'text';
                scope.valueProperty = attrs.valueProperty || 'id';

                // the modal properties
                scope.modalTemplateUrl = attrs.modalTemplateUrl;
                scope.modalAnimation = attrs.modalAnimation;

                // note properties
                scope.noteImg = attrs.noteImg || '';
                scope.noteText = attrs.noteText || '';
                scope.noteImgClass = attrs.noteImgClass || '';

                /* Initialise the modal
                * If a modal template URL has been provided, then use that,
                * otherwise use the default one, that uses the
                * "id" and "text" properties
                */
                if (scope.modalTemplateUrl) {
                    $ionicModal.fromTemplateUrl(
                        scope.modalTemplateUrl,
                            {
                                scope: scope,
                                animation: scope.modalAnimation
                            }
                        ).then(function(modal) {
                            scope.modal = modal;
                        }
                    );

                } else {
                    scope.modal = $ionicModal.fromTemplate(
                        '<ion-modal-view> <ion-header-bar class="bar-positive"> <button class="button button-positive button-icon ion-ios-arrow-back" ng-click="hideItems()"/> <h1 class="title">{{headerText}}</h1> <button class="button button-positive button-icon ion-checkmark" ng-show="multiSelect" ng-click="validate()"/> </ion-header-bar> <ion-content> <ion-list> <ion-item class="item-checkbox" ng-if="multiSelect" ng-repeat="item in items"> <label class="checkbox"> <input type="checkbox" ng-checked="item.checked" ng-model="item.checked"> </label>{{item.Name}}</ion-item> <label class="item" ng-click="validate(item)" ng-if="!multiSelect" ng-repeat="item in items">{{item.Name}}</label> </div></ion-content></ion-modal-view>',
                        {
                            scope: scope,
                            animation: scope.modalAnimation
                        }
                    );
                }

                scope.$on('$destroy', function() {
                    scope.modal.remove();
                });

                scope.getItemText = function(item) {
                    return scope.textProperty ? item[scope.textProperty] : item;
                };

                scope.getItemValue = function(item) {
                    return scope.valueProperty ? item[scope.valueProperty] : item;
                };

                // gets the text for the specified values
                scope.getText = function(value) {
                    // push the values into a temporary array so that they can be iterated through
                    var temp;
                    if (scope.multiSelect) {
                    temp = value ? value : []; // in case it hasn't been defined yet
                    } else {
                    temp = (value === null || (typeof value === 'undefined')) ? [] : [value]; // make sure it's in an array, anything other than null/undefined is ok
                    }

                    var text = '';
                    if (temp.length) {
                        // concatenate the list of selected items
                        angular.forEach(scope.items, function(item) {
                            for (var i = 0; i < temp.length; i++) {
                                if (scope.getItemValue(item) === temp[i]) {
                                    text += (text.length ? ', ' : '') + scope.getItemText(item);
                                    break;
                                }
                                }
                        });

                    } else {
                        text = scope.defaultText;
                    }

                    // if a callback has been specified for the text
                    return scope.getCustomTextCallback({value: value}) || text;
                };

                // hides the list
                scope.hideItems = function() {
                    scope.modal.hide();
                };

                // raised by watch when the value changes
                scope.onValueChanged = function(newValue) {
                    scope.text = scope.getText(newValue);

                    // notify subscribers that the value has changed
                    scope.valueChangedCallback({value: newValue});
                };

                // shows the list
                scope.showItems = function(event) {
                    event.preventDefault(); // prevent the event from bubbling

                    // for multi-select, make sure we have an up-to-date list of checked items
                    if (scope.multiSelect) {
                        // clone the list of values, as we'll splice them as we go through to reduce loops
                        var values = scope.value ? angular.copy(scope.value) : [];

                        angular.forEach(scope.items, function(item) {
                        // not checked by default
                        item[scope.checkedProperty] = false;

                        var val = scope.getItemValue(item);
                        for (var i = 0; i < values.length; i++) {
                            if (val === values[i]) {
                                item[scope.checkedProperty] = true;
                                values.splice(i, 0); // remove it from the temporary list
                                break;
                                }
                            }
                        });
                    }

                    scope.modal.show();
                };

                // validates the current list
                scope.validate = function(item) {
                    if (scope.multiSelect) {
                        scope.value = [];

                        if (scope.items) {
                            angular.forEach(scope.items, function(item) {
                                if (item[scope.checkedProperty]) {
                                    scope.value[scope.value.length] = scope.getItemValue(item);
                                }
                            });
                        }

                    } else {
                        if (scope.value !== 'undefined' && (item[scope.valueProperty] === scope.value)) {
                            scope.value = [];
                        } else {
                            scope.value = scope.getItemValue(item);
                        }
                    }

                    if (attrs.required === 'true') {
                        if (scope.value.length === 0) {
                            scope.required = true;
                        } else {
                            scope.required = false;
                        }
                    }

                    if (scope.value.length > 0) {
                        scope.text = scope.getText(scope.value);
                    } else {
                        scope.text = attrs.text;
                    }

                    var newValue = scope.value;
                    scope.valueChangedCallback({value: newValue});
                    scope.hideItems();
                };
            }
        };
    }
}());

