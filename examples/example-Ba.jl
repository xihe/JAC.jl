#
println("Ba) Tests of the dipole and em multipole amplitudes.")
#
grid = Radial.Grid("grid: exponential")
wa = Atomic.Computation("xx",  Nuclear.Model(26.); grid=grid, properties=JAC.AtomicLevelProperty[],
                        configs=[Configuration("1s 2s^2"), Configuration("1s 2s 2p"), Configuration("1s 2p^2")] )

wxa  = perform(wa; output=true)
wma  = wxa["multiplet:"]

flow = 6;    fup = 8;   ilow = 1;   iup = 3
println("\n\nDipole amplitudes:\n")
for  finalLevel in wma.levels
    for  initialLevel in wma.levels
        if  flow <= finalLevel.index <= fup   &&    ilow <= initialLevel.index <= iup
            ##x println("Levels with indices f = $(finalLevel.index) and i = $(initialLevel.index)")
            MultipoleMoment.dipoleAmplitude(finalLevel, initialLevel, grid; display=true)
        end
    end
end


println("\n\nElectromagnetic multipole-transition (absorption) amplitudes from Radiative.amplitude(..):\n")
for  finalLevel in wma.levels
    for  initialLevel in wma.levels
        if  flow <= finalLevel.index <= fup   &&    ilow <= initialLevel.index <= iup
            Radiative.amplitude("absorption", E1, Coulomb,  1.0, finalLevel, initialLevel, grid; display=true)
            Radiative.amplitude("absorption", M1, Magnetic, 1.0, finalLevel, initialLevel, grid; display=true)
        end
    end
end


println("\n\nElectromagnetic multipole-transition (absorption) amplitudes from MultipoleMoment.transitionAmplitude(..):\n")
for  finalLevel in wma.levels
    for  initialLevel in wma.levels
        if  flow <= finalLevel.index <= fup   &&    ilow <= initialLevel.index <= iup
            MultipoleMoment.transitionAmplitude(E1, Velocity, 1.0, finalLevel, initialLevel, grid; display=true)
            MultipoleMoment.transitionAmplitude(M1, Magnetic, 1.0, finalLevel, initialLevel, grid; display=true)
        end
    end
end


println("\n\nElectromagnetic multipole-moment amplitudes from MultipoleMoment.amplitude(..):\n")
for  finalLevel in wma.levels
    for  initialLevel in wma.levels
        if  flow <= finalLevel.index <= fup   &&    ilow <= initialLevel.index <= iup
            MultipoleMoment.amplitude(E1, Velocity, 1.0, finalLevel, initialLevel, grid; display=true)
            MultipoleMoment.amplitude(M1, Magnetic, 1.0, finalLevel, initialLevel, grid; display=true)
        end
    end
end


println("\n\nMomentum transfer amplitudes:\n")
for  finalLevel in wma.levels
    for  initialLevel in wma.levels
        if  flow <= finalLevel.index <= fup   &&    ilow <= initialLevel.index <= iup
            FormFactor.amplitude(1.0, finalLevel, initialLevel, grid; display=true)
        end
    end
end
