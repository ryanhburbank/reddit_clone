var redditCloneApp = angular.module('redditClone', ['ui.router']);

redditCloneApp.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: '/home.html',
      controller: 'HomeCtrl'
    })
    .state('posts', {
      url: '/posts/{id}',
      templateUrl: '/post.html',
      controller: 'PostCtrl'
    });

  $urlRouterProvider.otherwise('home');
});

redditCloneApp.factory('postManager', function(){
  return { posts: [] };
});

redditCloneApp.controller('HomeCtrl', function($scope, postManager){
  $scope.posts = postManager.posts;

  var clearForm = function() {
    $scope.title = '';
    $scope.link = '';
  };

  var titleBlank = function() {
    return ($scope.title === '' || $scope.title === undefined) ? true : false
  };

  $scope.addPost = function() {
    if (titleBlank()) { return; };

    $scope.posts.push({
      title: $scope.title,
      link: $scope.link,
      upvotes: 0,
      comments: [
        { author: 'Joe', body: 'Cool post!', upvotes: 0 },
        { author: 'Bob', body: 'Great idea but everything is wrong!', upvotes: 0 }
      ]
    });
    clearForm();
  };

  $scope.upvote = function(post) { post.upvotes += 1; };
  $scope.downvote = function(post) { post.upvotes -= 1; };
});

redditCloneApp.controller('PostCtrl', function($scope, $stateParams, postManager) {
  $scope.post = postManager.posts[$stateParams.id];

  $scope.addComment = function() {
    if ($scope.body === '') { return; }

    $scope.post.comments.push({
      body: $scope.body,
      author: 'user',
      upvotes: 0
    });

    $scope.body = '';
  };

  $scope.upvote = function(post) { post.upvotes += 1; };
  $scope.downvote = function(post) { post.upvotes -= 1; };
});
