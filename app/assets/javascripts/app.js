var redditCloneApp = angular.module('redditClone', ['ui.router', 'templates']);

redditCloneApp.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'HomeCtrl',
      resolve: {
        postPromise: function(postService){
          return postService.index();
        }
      }
    })
    .state('posts', {
      url: '/posts/{id}',
      templateUrl: 'posts/_posts.html',
      controller: 'PostsCtrl',
      resolve: {
        post: function($stateParams, postService) {
          return postService.get($stateParams.id);
        }
      }
    });

  $urlRouterProvider.otherwise('home');
});
