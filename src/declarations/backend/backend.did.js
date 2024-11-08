export const idlFactory = ({ IDL }) => {
  const BlogPost = IDL.Record({
    'id' : IDL.Nat,
    'title' : IDL.Text,
    'content' : IDL.Text,
    'timestamp' : IDL.Int,
  });
  return IDL.Service({
    'createPost' : IDL.Func([IDL.Text, IDL.Text], [BlogPost], []),
    'deletePost' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'getPost' : IDL.Func([IDL.Nat], [IDL.Opt(BlogPost)], ['query']),
    'getPosts' : IDL.Func([], [IDL.Vec(BlogPost)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
