angular.module('equitrack.constants', [])  
  .constant('apiHostDevelopment', 'https://etoolsdev.localtunnel.me')
  .constant('defaultConnection', 2)
  .constant('LOCALES', {
      'locales': {
          'en-US': 'English (US)',
          'fr-FR': 'Français (France)',
          'pt-BR': 'Português (Brasil)',
          'es-ES': 'Español'
      },
      'preferredLocale': 'en-US'
  });