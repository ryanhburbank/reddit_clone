redditCloneApp.controller('CommentsCtrl', function($scope, commentService, comment) {
  $scope.comment = comment;
  foo  = $scope.comment;

  $scope.addComment = function() {
    if ($scope.body === '') { return; }

    commentService.addComment(comment.id, {
      body: $scope.body
    }).success(function(newComment) {
      $scope.comment.comments = $scope.comment.comments || [];
      $scope.comment.comments.push(newComment);
    });

    $scope.body = '';
  };

  $scope.upvote = function(comment) { commentService.upvote(comment); };
  $scope.downvote = function(comment) { commentService.downvote(comment); };
});
