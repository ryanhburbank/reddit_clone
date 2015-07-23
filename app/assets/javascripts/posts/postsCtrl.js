redditCloneApp.controller('PostsCtrl', function($scope, postService, post) {
  $scope.post = post;

  $scope.addComment = function() {
    if ($scope.body === '') { return; }

    postService.addComment(post.id, {
      body: $scope.body
    }).success(function(comment) {
      $scope.post.comments = $scope.post.comments || [];
      $scope.post.comments.push(comment);
    });

    $scope.body = '';
  };

  $scope.upvote = function(comment) { postService.upvoteComment(post, comment); };
  $scope.downvote = function(comment) { postService.downvoteComment(post, comment); };
});
