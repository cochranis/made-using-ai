program IdleGame
    implicit none
    
    integer :: points = 0
    integer :: time_step = 1
    integer :: choice
    
    print *, "Welcome to the Idle Game!"
    print *, "You currently have ", points, " points."
    
    do
        print *, "What would you like to do?"
        print *, "1. Gather resources"
        print *, "2. Exit"
        print *, "Enter your choice: "
        read *, choice
        
        select case(choice)
            case(1)
                call gather_resources(points, time_step)
            case(2)
                exit
            case default
                print *, "Invalid choice. Please try again."
        end select
    end do
    
contains

    subroutine gather_resources(points, time_step)
        implicit none
        integer, intent(inout) :: points
        integer, intent(in) :: time_step
        
        print *, "Gathering resources..."
        ! Simulate gathering resources over time
        points = points + time_step
        
        print *, "You now have ", points, " points."
    end subroutine gather_resources

end program IdleGame
