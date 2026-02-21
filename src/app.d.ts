// See https://svelte.dev/docs/kit/types#app.d.ts
// for information about these interfaces

export interface HackClubUser {
	id: string;
	email: string;
	name: string;
	username?: string;
	avatar?: string;
}

declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			user: HackClubUser | null;
		}
		interface PageData {
			user: HackClubUser | null;
		}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};
