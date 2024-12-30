local ActionAnimator = { fadeTime = 0.15 }
ActionAnimator.__index = ActionAnimator

function ActionAnimator:LoadAnimations(animations: Folder)
	for _, animation in animations:GetChildren() do
		self.animationTracks[animation.Name] = self.animator:LoadAnimation(animation)
	end
end

function ActionAnimator:StopAllAnimations(fadeTime: number?)
	fadeTime = fadeTime or self.fadeTime

	for _, animationTrack in self.animationTracks :: { AnimationTrack } do
		animationTrack:Stop(fadeTime)
	end
end

function ActionAnimator:GetAnimationTrack(animationName: string)
	return self.animationTracks[animationName]
end

function ActionAnimator:PlayAnimation(name: string, fadeTime: number?)
	fadeTime = fadeTime or self.fadeTime

	local animationTrack = self:GetAnimationTrack(name)
	if not animationTrack then
		warn("animation not found", name)
		return
	end

	animationTrack:Play(fadeTime)
end

function ActionAnimator:StopAnimation(name: string, fadeTime: number?)
	fadeTime = fadeTime or self.fadeTime

	local animationTrack = self:GetAnimationTrack(name)
	if not animationTrack then
		return
	end

	animationTrack:Stop(fadeTime)
end

function ActionAnimator.new(animator: Animator, defaultFadeTime: number?)
	local self = setmetatable({ fadeTime = defaultFadeTime or ActionAnimator.fadeTime }, ActionAnimator)
	self.animator = animator

	self.animationTracks = {}

	return self
end

function ActionAnimator:Destroy()
	self:StopAllAnimations()
end

return ActionAnimator
