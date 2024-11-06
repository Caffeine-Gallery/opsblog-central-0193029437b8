import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface BlogPost {
  'id' : bigint,
  'title' : string,
  'content' : string,
  'timestamp' : bigint,
}
export interface _SERVICE {
  'createPost' : ActorMethod<[string, string], BlogPost>,
  'deletePost' : ActorMethod<[bigint], boolean>,
  'getPost' : ActorMethod<[bigint], [] | [BlogPost]>,
  'getPosts' : ActorMethod<[], Array<BlogPost>>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
