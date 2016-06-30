Object.defineProperty(
    protractor.promise.Promise.prototype,
    'should',
    Object.getOwnPropertyDescriptor(Object.prototype, 'should')
);