(function() {
    'use strict';

    angular
        .module('app.core')
        .constant('apiHostDevelopment', '@@apiHostDevelopment')
        .constant('defaultConnection', @@defaultConnection)
        .constant('LOCALES', {
            'locales': {
                'en-US': 'English (US)',
                'fr-FR': 'Français (France)',
                'pt-BR': 'Português (Brasil)',
                'es-ES': 'Español'
          },
          'preferredLocale': 'en-US'
        })        
        .constant(
            'TripVars', {
                'checkboxes' : [
                    'ta_drafted', 
                    'security_granted'
                ],

                'cards': [
                    'travel_routes',
                    'files',
                    'action_points',
                    'trip_funds'
                ]
            }
        );
})();