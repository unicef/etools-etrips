angular.module('equitrack.constants', [])  
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
  });