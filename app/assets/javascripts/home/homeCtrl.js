redditCloneApp.controller('HomeCtrl', function($scope, postService){
  $scope.posts = postService.posts;

  var clearForm = function() {
    $scope.title = '';
    $scope.link = '';
  };

  var titleBlank = function() {
    return ($scope.title === '' || $scope.title === undefined) ? true : false
  };

  $scope.addPost = function() {
    if (titleBlank()) { return; };

    postService.create({
      title: $scope.title,
      link: $scope.link,
    });

    clearForm();
  };

  $scope.upvote = function(post) { postService.upvote(post); };
  $scope.downvote = function(post) { postService.downvote(post); };
});

