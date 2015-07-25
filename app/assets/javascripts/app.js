var redditCloneApp = angular.module('redditClone', ['ui.router', 'templates', 'Devise']);

redditCloneApp.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('/login', {
      url: '/login',
      templateUrl: 'auth/_login.html',
      controller: 'AuthCtrl',
      onEnter: function($state, Auth) {
        Auth.currentUser().then(function() {
          $state.go('home');
        })
      }
    })
    .state('/register', {
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onEnter: function($state, Auth) {
        Auth.currentUser().then(function() {
          $state.go('home');
        })
      }
    })
    .state('home', {
      url: '/',
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
    })
    .state('comments', {
      url: '/comments/{id}',
      templateUrl: 'comments/_comments.html',
      controller:  'CommentsCtrl',
      resolve: {
        comment: function($stateParams, commentService) {
          return commentService.get($stateParams.id);
        }
      }
    });

  $urlRouterProvider.when('', '/');
  $urlRouterProvider.otherwise('/');
});
