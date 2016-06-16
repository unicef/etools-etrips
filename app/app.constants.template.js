(function() {
    'use strict';

    angular
        .module('app.core')
        .constant('apiHostDevelopment', '@@apiHostDevelopment')
        .constant('DATE_FORMAT', 'dd/MM/yyyy')
        .constant('DATE_TIME_FORMAT', 'dd/MM/yyyy HH:mm')
        .constant('VERSION', '@@version')
        .constant('defaultConnection', @@defaultConnection)
        .constant('DEBUG_INFO_ENABLED', @@debugInfoEnabled)
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
                'checkboxes': [
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
