
mutable struct Q1_solver
    ε::Float64
    max_iter::Int #最大迭代次数   
    iter_idx::Int #迭代次数
    x_n::Float64
    x_n_1::Float64
end

lim = Q1_solver(10^-8,10000000,0,1.0,1.0)
lim.ε = 10^-8
lim.max_iter = 10000000
lim.iter_idx = 0
lim.x_n = 5^0.5
lim.x_n_1 = 5^0.5
lim

while(lim.iter_idx<lim.max_iter)
    lim.x_n_1 = lim.x_n
    lim.x_n = lim.x_n^0.5
    lim.iter_idx += 1
    if abs(lim.x_n-lim.x_n_1)<lim.ε
        break
    end
end
lim.x_n,lim.iter_idx

mutable struct Q2_solver
    ε::Float64
    max_iter::Int #最大迭代次数
    iter_idx::Int #迭代次数
    n::Int
    sign::Int
    pi::Float64
end

lim = Q2_solver(10^-8,10000000,0,1,1,0.0)
lim.max_iter = 100000000
lim.iter_idx = 0
lim.n = 0
lim.sign = 1
lim.pi = 0
lim

lim.ε = 10^-4
while(lim.n<lim.max_iter)         
    if 4/(2*(lim.n)+1)<lim.ε
        break
    end
    lim.n+=1  
    lim.pi += lim.sign*4/(2*(lim.n)-1)#sum a_n
    lim.sign*=-1
end
if(4/(2*(lim.n)+1)<lim.ε)
    print("succeed")
else
    print("failed")
end
lim.iter_idx,lim.n,lim.pi,1/(2*(lim.n)+1)

lim.ε = 10^-8
lim.max_iter = 200000000
while(lim.n<lim.max_iter)         
    if 4/(2*(lim.n)+1)<lim.ε
        break
    end    
    lim.n+=1  
    lim.pi += lim.sign*4/(2*(lim.n)-1)#sum a_n
    lim.sign*=-1
end
if(4/(2*(lim.n)+1)<lim.ε)
    print("succeed")
else
    print("failed")
end
lim.iter_idx,lim.n,lim.pi,1/(2*(lim.n)+1)

using Plots
n_s=[2,5,10]
x= collect(0:0.1:1.6*pi);

y= [sum([(-1)^i.*x.^(2*i+1)/factorial(big(2*i+1)) for i in collect(0:n)]) for n in n_s]
plot(x,y,label=["n=2","n=5","n=10"],line = (:arrow, :circle, :star5, 1, 6))
plot!(x,sin.(x),label="sin x",seriestype=:scatter)

using Plots, ProgressMeter

for step in 20 ./ [100 200 400]
    print(step)
end

collect(-10:0.1:10)

for step in 20 ./ [100 200 400]
    print("Currently step: ", step)
    x= collect(-10:step:10-step);
    y= collect(-10:step:10-step);
    pyplot(leg=false, ticks=nothing) #change to the pyplot backend and define some defaults
    x = y = range(-5, stop = 5, length = 40)
    zs = zeros(0,40)
    n = 100

    # create a progress bar for tracking the animation generation
    prog = Progress(n,1)

    @gif for i in range(0, stop = 2π, length = n)
        f(x,y) = exp(-abs(x))+cos(x+y)+1/(x^2+y^2+1)

        # create a plot with 3 subplots and a custom layout
        l = @layout [a{0.7w} b; c{0.2h}]
        p = plot(x, y, f, st = [:surface, :contourf], layout=l)

        # induce a slight oscillating camera angle sweep, in degrees (azimuth, altitude)
        plot!(p[1], camera=(15*cos(i), 40))

        # add a tracking line
        fixed_x = zeros(40)
        z = map(f, fixed_x, y)
        plot!(p[1], fixed_x, y, z, line = (:black, 5, 0.2))
        vline!(p[2], [0], line = (:black, 5))

        # add to and show the tracked values over time
        global zs = vcat(zs, z')
        plot!(p[3], zs, alpha = 0.2, palette = cgrad(:blues).colors)

        # increment the progress bar
        next!(prog)
    end
end


