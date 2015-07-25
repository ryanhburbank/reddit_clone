redditCloneApp.controller('PostsCtrl', function($scope, postService, commentService, post) {
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

  $scope.upvote = function(comment) { commentService.upvote(comment); };
  $scope.downvote = function(comment) { commentService.downvote(comment); };
});
